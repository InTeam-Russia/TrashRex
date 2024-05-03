<?php

namespace models;

use core\db;

class company
{
    /**
     * @var int id компании
     */
    public int $id;
    /**
     * @var string название компании
     */
    public string $name;
    /**
     * @var string|null описание компании или null
     */
    public ?string $description;
    /**
     * @var string|null логотип компании или null
     */
    public ?string $logo;

    /**
     * проверяет компанию на существование
     * @param int $id id компании
     * @return bool существует ли компания
     * @throws \Exception ошибка execute
     */
    public static function exists(int $id) : bool {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT * FROM companies WHERE id = ?");
        $sth->bindParam(1, $id, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу выполнить поиск компании по id");
        }
        return $sth->rowCount() != 0;
    }

    /**
     * Получает компанию в виде модели \models\company
     * @param int $id id компании
     * @return self
     * @throws \Exception ошибка execute или fetch
     */
    public static function get(int $id) : self {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT * FROM companies WHERE id = ?");
        $sth->bindParam(1, $id, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу выполнить выборку компании по id");
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\company');
        $comp = $sth->fetch();
        if($comp === false) {
            throw new \Exception("Не могу прочитать результат выборки компании");
        }
        return $comp;
    }

}