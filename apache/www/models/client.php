<?php

namespace models;

use core\db;

class client
{
    /**
     * @var int id пользователя
     */
    public int $id;
    /**
     * @var string имя пользователя
     */
    public string $name;
    /**
     * @var string фамилия пользователя
     */
    public string $surname;
    /**
     * @var string путь к фото пользователя
     */
    public string $photo;

    /**
     * Получает клиента по id
     * @param int $id id пользователя
     * @return client
     */
    public static function get(int $id) : self {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT * FROM clients WHERE id = ?");
        $sth->bindParam(1, $id, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу запросить клиента с таким id");
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\client');
        $result = $sth->fetch();
        if($result === false) {
            throw new \Exception("Не могу прочитать данные клиента с таким id");
        }
        return $result;
    }

    public function getUser() : user {
        return user::get($this->id);
    }
}