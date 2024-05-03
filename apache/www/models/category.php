<?php

namespace models;

use core\db;

class category
{
    public int $id;
    public string $name;
    public bool $icon = false;
    public static function exists(int $id) : bool {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT name FROM public.categories WHERE id = ?");
        $sth->bindParam(1, $id, \PDO::PARAM_INT);
        $sth->execute();
        return $sth->rowCount() !== 0;
    }


    /**
     * @return int id новой категории
     * @throws \Exception
     */
    public function add() : int {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("INSERT INTO public.categories(name, icon) VALUES(?, ?)  RETURNING id;");
        $sth->bindParam(1, $this->name, \PDO::PARAM_STR);
        $sth->bindParam(2, $this->icon, \PDO::PARAM_BOOL);
        if (!$sth->execute()) {
            throw new \Exception("Не могу создать категорию. Возможно, она уже существует");
        }
        $result = $sth->fetch(\PDO::FETCH_NUM);
        $this->id = (int)$result[0];
        return $this->id;
    }

    public static function getById(int $id) : self {
        if(!self::exists($id)) {
            throw new \Exception("Категория не существует");
        }
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT * FROM public.categories WHERE id = ?");
        $sth->bindParam(1, $id, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу найти такую категорию");
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\category');
        $result = $sth->fetch();
        if($result === false) {
            throw new \Exception("Не удалось загрузить категорию");
        }
        return $result;
    }

    public static function getAll() {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT * FROM categories");
        if(!$sth->execute()) {
            throw new \Exception("Не могу запросить список категорий");
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\category');
        $array = $sth->fetchAll();
        if($array === false) {
            throw new \Exception("Не могу прочитать список категорий");
        }
        return $array;
    }

    public static function find(string $name) {
        $db = db::getInstance();
        $name = '%' . str_replace('%', '\%', $name) . '%';
        $sth = $db->pdo->prepare("SELECT * FROM public.categories WHERE name LIKE :name");
        $sth->bindValue(':name', $name);
        if(!$sth->execute()) {
            throw new \Exception("Не могу выполнить поиск");
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\category');
        $array = $sth->fetchAll();
        if($array === false) {
            throw new \Exception("Не могу прочитать результат поиска");
        }
        return $array;
    }

}