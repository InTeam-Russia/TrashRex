<?php

namespace models;

use core\db;

class cart
{
    /**
     * @var int id клиента
     */
    public int $client_id;
    /**
     * @var product_units[] массив продукции
     */
    public array $products;

    /**
     * Получает корзину клиента
     * @param int $user_id id пользователя-клиента
     * @return self корзина
     * @throws \Exception execute: Не могу запросить содержимое корзины
     * @throws \Exception fetchAll: Не могу получить содержимое корзины
     */
    public static function get(int $user_id) : self {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT * FROM cart WHERE client_id = ?");
        $sth->bindParam(1, $user_id, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу запросить содержимое корзины");
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\product_units');
        $result = $sth->fetchAll();
        if($result === false) {
            throw new \Exception("Не могу получить содержимое корзины");
        }
        $cart = new self;
        $cart->client_id = $user_id;
        $cart->products = $result;
        return $cart;
    }

    /**
     * Очищает корзину
     * @return void
     */
    public function clear() {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("DELETE FROM cart WHERE client_id = ?");
        $sth->bindParam(1, $this->client_id, \PDO::PARAM_INT);
    }
}