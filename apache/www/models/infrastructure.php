<?php

namespace models;

use core\db;

class infrastructure
{
    /**
     * @var db экземпляр базы данных
     */
    private db $db;
    /**
     * @var int компания, об инфраструктуре которой идёт речь
     */
    public int $company_id;
    /**
     * @var int город, о котором идёт речь
     */
    public int $city;
    /**
     * @var bool наличие склада в городе
     */
    public bool $storage;
    /**
     * @var bool наличие пункта выдачи в городе
     */
    public bool $dp;

    public function __construct() {
        $this->db = db::getInstance();
    }


    /**
     * Получает состояние инфраструктуры компании в городе
     * @param int $company_id id компании
     * @param int $city_id id города
     * @return infrastructure модель инфраструктуры
     * @throws \Exception
     */
    public static function getInstance(int $company_id, int $city_id) : self {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT * FROM infrastructure WHERE company_id = :company_id AND city = :city_id");
        $sth->bindParam(':company_id', $company_id, \PDO::PARAM_INT);
        $sth->bindParam(':city_id', $city_id, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу получить информацию об инфраструктуре компании в данном городе");
        }
        if($sth->rowCount() == 0) {
            $sth = $db->pdo->prepare("INSERT INTO infrastructure(company_id, city, storage, dp) VALUES (:company_id, :city_id, :storage, :dp)");
            $sth->bindParam(':company_id', $company_id, \PDO::PARAM_INT);
            $sth->bindParam(':city_id', $city_id, \PDO::PARAM_INT);
            $sth->bindValue(':storage', false, \PDO::PARAM_BOOL);
            $sth->bindValue(':dp', false, \PDO::PARAM_BOOL);
            if(!$sth->execute()) {
                throw new \Exception("Не могу создать информацию об инфраструктуре компании в данном городе");
            }
            return self::getInstance($company_id, $city_id);
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\infrastructure');
        $result = $sth->fetch();
        if($result === false) {
            throw new \Exception("Не могу прочитать информацию об инфраструктуре компании в данном городе");
        }
        return $result;
    }

    /**
     * Создаёт склад в городе
     * @return void
     * @throws \Exception Не могу добавить склад компании в город
     */
    public function createStorage() {
        try {
            $this->updateInfrastructure("storage = true");
            $this->storage = true;
        } catch(\Exception $ex) {
            throw new \Exception("Не могу добавить склад компании в город");
        }
    }

    /**
     * Создаёт пункт выдачи в городе
     * @return void
     * @throws \Exception Не могу добавить пункт выдачи компании в город
     */
    public function createDeliveryPoint() {
        try {
            $this->updateInfrastructure("dp = true");
            $this->dp = true;
        } catch(\Exception $ex) {
            throw new \Exception("Не могу добавить пункт выдачи компании в город");
        }
    }

    /**
     * Удаляет склад из города
     * @return void
     * @throws \Exception Не могу удалить склад компании из города
     */
    public function removeStorage() {
        try {
            $this->updateInfrastructure("storage = false");
        } catch(\Exception $ex) {
            throw new \Exception("Не могу удалить склад компании из города");
        }
    }

    /**
     * Проверяет, есть ли в городе склад
     * @return bool
     */
    public function hasStorage() : bool {
        return $this->storage;
    }

    /**
     * @return bool Проверяет, есть ли в городе пункт выдачи
     */
    public function hasDeliveryPoint() : bool {
        return $this->dp;
    }

    /**
     * Удаляет пункт выдачи из города
     * @return void
     * @throws \Exception Не могу удалить пункт выдачи компании в город
     */
    public function removeDeliveryPoint() {
        try {
            $this->updateInfrastructure("dp = false");
        } catch(\Exception $ex) {
            throw new \Exception("Не могу удалить пункт выдачи компании в город");
        }
    }

    /**
     * Выполняет запрос на обновление состояния инфраструктуры в городе
     * @param string $sql_set_fragment фрагмент SQL-запроса между SET и WHERE
     * @param \Closure|null $sthFunction лямбда-функция, в которую в качестве аргумента передаётся \PDOStatement и которая вызывается перед execute
     * @return \PDOStatement состояние функции после execute
     * @throws \Exception Не могу обновить состояние
     */
    private function updateInfrastructure(string $sql_set_fragment, \Closure $sthFunction = null) : \PDOStatement {
        $sth = $this->db->pdo->prepare("UPDATE infrastructure SET " .  $sql_set_fragment . " WHERE company_id = :company_id AND city = :city_id");
        $this->bindCompanyAndCity($sth);
        if(!is_null($sthFunction)) {
            /* пример: $sthFunction = function(\PDOStatement &$sth) { }; */
            $sthFunction($sth);
        }
        if(!$sth->execute()) {
            throw new \Exception("Не могу обновить состояние");
        }
        return $sth;
    }

    /**
     * Выполняет поиск по инфраструктуре с фильтрами и постраничной пагинацией
     * @param array $filters Фильтры (company_id, city_id)
     * @param int $page Номер страницы (по умолчанию 1)
     * @param int $perPage Пар город-компания на страницу (по умолчанию 25)
     * @return array
     * @throws \Exception execute или fetchAll
     */
    public static function filteredSearch(array $filters, bool $pagination, int $page = 1, int $perPage = 25) {
        $sql = 'SELECT * FROM infrastructure';
        $sth = self::bindInfrastructureFilters($sql, $filters, $pagination, $page, $perPage);
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\infrastructure');
        $result = $sth->fetchAll();
        if($result === false) {
            throw new \Exception('Не могу обработать результат поиска');
        }
        return $result;
    }

    /**
     * Подсчитывает количество совпадений для поискового запроса
     * @param array $filters фильтры (company_id, city_id)
     * @param int $page номер страницы
     * @param int $perPage Пар город-компания на странице
     * @return int количество совпадений
     * @throws \Exception Не могу обработать результат поиска
     * @throws \Exception Не могу скомпилировать поисковый запрос
     * @throws \Exception Не могу выполнить поиск
     */
    public static function filteredSearchCount(array $filters) : int {
        $sql = 'SELECT COUNT(*) FROM infrastructure';
        $sth = self::bindInfrastructureFilters($sql, $filters, false);
        $result = $sth->fetch(\PDO::FETCH_NUM);
        if($result === false) {
            throw new \Exception('Не могу обработать результат поиска');
        }
        return $result[0];
    }

    /**
     * Достраивает поисковый вопрос начиная с WHERE согласно заданным фильтрам
     * @param string $sql часть SQL-запроса до WHERE
     * @param array $filters массив фильтров
     * @param bool $pagination нужна ли пагинация?
     * @param int $page номер страницы
     * @param int $perPage Пар город-компания на странице
     * @return \PDOStatement executed запрос
     * @throws \Exception
     */
    private static function bindInfrastructureFilters(string $sql, array $filters, bool $pagination, int $page = 1, int $perPage = 25) : \PDOStatement {
        $filtersColumns = [
            'company_id'   => ' company_id = :company_id',
            'city_id'      => ' city = :city_id'
        ];

        $binds = [
            'company_id'   => \PDO::PARAM_INT,
            'city_id'      => \PDO::PARAM_INT
        ];
        return db::getInstance()->bindFilters($sql, $filters, $filtersColumns, $binds, $pagination, $page, $perPage);
    }

    /**
     * Биндит :company_id и :city_id
     * @param \PDOStatement $sth
     * @return void
     */
    private function bindCompanyAndCity(\PDOStatement &$sth) {
        $sth->bindParam(':company_id', $this->company_id, \PDO::PARAM_INT);
        $sth->bindParam(':city_id', $this->city, \PDO::PARAM_INT);
    }
}