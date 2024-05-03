<?php

namespace models;

use core\db;

/**
 * Модель города
 */
class city
{
    /**
     * @var int id города
     */
    public int $id;
    /**
     * @var string Название города
     */
    public string $name;
    /**
     * @var string Ссылка на герб города
     */
    public string $arms;

    /**
     * Получает объект города по id
     * @param int $id id города
     * @return self город
     * @throws \Exception
     */
    public static function get(int $id) : self {
        $db = db::getInstance();
        $sth = $db->pdo->prepare('SELECT * FROM cities WHERE id = :id');
        if(!$sth) {
            throw new \Exception("Не могу скомпилировать запрос города");
        }
        $sth->bindParam(':id', $id, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу запросить данные о городе");
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\city');
        $result = $sth->fetch();
        if($result === false) {
            throw new \Exception("Не могу получить данные о городе");
        }
        return $result;
    }


    /**
     * Проверяет, существует ли город с заданным id
     * @param int $id id города
     * @return bool
     * @throws \Exception prepare: Не могу скомпилировать запрос города
     * @throws \Exception execute: Не могу запросить данные о городе
     * @throws \Exception fetch: Не могу получить данные о существовании города
     */
    public static function exists(int $id) : bool {
        $db = db::getInstance();
        $sth = $db->pdo->prepare('SELECT COUNT(*) FROM cities WHERE id = :id');
        if(!$sth) {
            throw new \Exception("Не могу скомпилировать запрос города");
        }
        $sth->bindParam(':id', $id, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу запросить данные о городе");
        }
        $result = $sth->fetch(\PDO::FETCH_NUM);
        if($result === false) {
            throw new \Exception("Не могу получить данные о существовании города");
        }
        return $result[0] > 0;
    }

    /**
     * @return array Массив с городами
     * @throws \Exception pdo->prepare: Не могу подготовить запрос
     * @throws \Exception pdo->execute: Не могу выполнить запрос
     * @throws \Exception pdo->fetchAll: Не могу прочесть список городов
     */
    public static function getAll() : array {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT * FROM cities");
        if(!$sth) {
            throw new \Exception("Не могу подготовить запрос");
        }
        if(!$sth->execute()) {
            throw new \Exception("Не могу выполнить запрос");
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\city');
        $result = $sth->fetchAll();
        if($result === false) {
            throw new \Exception("Не могу прочесть список городов");
        }
        return $result;
    }

    public static function searchCount(string $name) : int {
        $sql = 'SELECT COUNT(*) FROM cities';
        $sth = self::bindCityFilters($sql, $name, false);
        //$sth->setFetchMode(\PDO::FETCH_CLASS, '\models\city');
        $result = $sth->fetch(\PDO::FETCH_NUM);
        if($result === false) {
            throw new \Exception("Не могу извлечь результаты подсчёта");
        }
        return $result[0];
    }

    public static function search(string $name, bool $pagination, int $page = 1, int $perPage = 25) {
        $sql = 'SELECT * FROM cities';
        $sth = self::bindCityFilters($sql, $name, false);
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\city');
        $result = $sth->fetchAll();
        if($result === false) {
            throw new \Exception("Не могу извлечь результаты подсчёта");
        }
        return $result;
    }

    public static function bindCityFilters(string $sql, string $name, bool $pagination, int $page = 1, int $perPage = 25) : \PDOStatement {
        $filters = [
            'name'        => $name
        ];
        $filtersColumns = [
            'name'         => ' name LIKE :name'
        ];

        $binds = [
            'name'         => 'STR_FRAGMENT'
        ];
        return db::getInstance()->bindFilters($sql, $filters, $filtersColumns, $binds, $pagination, $page, $perPage);
    }
}