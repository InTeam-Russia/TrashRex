<?php

namespace models;

use core\db;

class storage
{
    /**
     * @var int id компании, владеющей складом
     */
    public int $company_id;
    /**
     * @var int id города, в котором или близ которого расположен склад
     */
    public int $city_id;
    /**
     * @var product_units[] массив продукции
     */
    public array $products;

    /**
     * Получает модель склада с массивом продукции
     * @param int $company_id компании, владеющей складом
     * @param int $city_id id города, в котором или близ которого расположен склад
     * @return storage
     * @throws \Exception
     */
    public static function getInstance(int $company_id, int $city_id) : storage {
        $db = db::getInstance();
        $sth = $db->pdo->prepare("SELECT * FROM storage_products WHERE company_id = ?");
        $sth->bindParam(1, $user_id, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу запросить содержимое склада");
        }
        $sth->setFetchMode(\PDO::FETCH_CLASS, '\models\product_units');
        $result = $sth->fetchAll();
        if($result === false) {
            throw new \Exception("Не могу получить содержимое склада");
        }
        $cart = new self;
        $cart->company_id = $user_id;
        $cart->products = $result;
        return $cart;
    }

    /**
     * Добавляет продукт на склад
     * @param int $product_id
     * @param int $amount
     * @return void
     * @throws \Exception
     */
    public function addProduct(int $product_id, int $amount) {
        $db = db::getInstance();
        $hasProduct = $this->hasProduct($product_id);
        if($hasProduct) {
            $sth = $db->pdo->prepare("UPDATE storage_products SET amount = amount + :amount WHERE company_id = :company_id AND city_id = :city_id AND product_id = :product_id");
        } else {
            $sth = $db->pdo->prepare("INSERT INTO storage_products(company_id, city_id, product_id, amount) VALUES (:company_id, :city_id, :product_id, :amount)");
        }
        $sth->bindParam(':company_id', $this->company_id, \PDO::PARAM_INT);
        $sth->bindParam(':city_id', $this->city_id, \PDO::PARAM_INT);
        $sth->bindParam(':product_id', $product_id, \PDO::PARAM_INT);
        $sth->bindParam(':amount', $amount, \PDO::PARAM_INT);
        if(!$sth->execute()) {
            throw new \Exception("Не могу добавить/обновить информацию о продукте на складе");
        }
        if($hasProduct) {
            foreach($this->products as $product) {
                if($product->product_id == $product_id) {
                    $product->amount += $amount;
                    break;
                }
            }
        }
    }

    /**
     * Извлекает продукт со склада ($_POST['product_id'], $_POST['amount'])
     * @param int $storage_id id склада
     * @return void
     */
    public function takeProduct(int $product_id, int $amount) {
        $db = db::getInstance();

    }

    /**
     * Проверяет, есть ли информация о данном продукте на данном складе
     * @param int $product_id айдишник продукта
     * @return bool
     */
    public function hasProduct(int $product_id) : bool {
        foreach($this->products as $product) {
            if($product->product_id == $product_id) {
                return true;
            }
        }
        return false;
    }
}