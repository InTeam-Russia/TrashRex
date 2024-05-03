<?php

namespace models;

use core\db;
use core\pythonApi;
use core\singleton;

class user
{
    /**
     * @var int id пользователя
     */
    public int $id;
    /**
     * @var string почта
     */
    public string $email;
    /**
     * @var bool активен ли
     */
    public bool $is_active;
    /**
     * @var bool подтверждена ли почта
     */
    public bool $is_verified;
    /**
     * @var bool является ли админом
     */
    public bool $is_superuser;
    /**
     * @var int номер роли (0 - компания, 1 - клиент)
     */
    public int $role;

    /**
     * Обращаясь к Python API, проверяет на авторизацию.
     * @return array ответ Python API в виде ассоциативного массива со структурой, соответствующей методу /auth/is_authorized
     */
    public static function is_authorised() : array {
        $python = pythonApi::getInstance();
        $cu = $python->createRequest('/auth/is_authorized');
        /* todo дописать api
        $data = $python->sendRequest($cu);
        Пользователь авторизован:
        Код 200, сообщение: {"id": id, "role": role}

        Пользователь не авторизован:
        Код 401, сообщение: {"details": "Unauthorized"}
        */
        $data = json_decode('{ "id": 1, "role": "company" }', true);
        return $data;
    }

    /**
     * Получает пользователя (не клиента!) по id
     * @param int $id id пользователя
     * @return self модель пользователя
     * @throws \Exception execute: Не могу запросить пользователя с таким id
     * @throws \Exception fetch: Не могу прочитать данные пользователя с таким id
     */
    public static function get(int $id) : self {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT * FROM users WHERE id = ?");
        $sth->bindParam(1, $id, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу запросить пользователя с таким id");
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\user');
        $result = $sth->fetch();
        if($result === false) {
            throw new \Exception("Не могу прочитать данные пользователя с таким id");
        }
        return $result;
    }

    /**
     * Возвращает модель пользователя, под которым мы авторизованы, или null, если мы гости
     * @return user|null модель пользователя (null для гостя)
     * @throws \Exception
     */
    public static function getMe() : ?self {
        $authorised = self::is_authorised();
        if(!isset($authorised['id'])) {
            return null;
        }
        return self::get($authorised['id']);
    }

    public function isCompany() {
        return $this->role == 0;
    }

    public function isClient() {
        return $this->role == 1;
    }
}