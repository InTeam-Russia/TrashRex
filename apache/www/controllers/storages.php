<?php

namespace controllers;

class storages
{
    /**
     * Получает массив продуктов на складе
     * @param int $storage_id id склада
     * @return void
     */
    public function getProducts(int $storage_id) {

    }

    /**
     * Добавляет продукт на склад ($_POST['product_id'], $_POST['amount'])
     * @param int $storage_id id склада
     * @return void
     */
    public function addProduct(int $storage_id) {
        // $_POST['product_id'], $_POST['amount']
    }

    /**
     * Извлекает продукт со склада ($_POST['product_id'], $_POST['amount'])
     * @param int $storage_id id склада
     * @return void
     */
    public function takeProduct(int $storage_id) {
        // $_POST['product_id'], $_POST['amount']
    }
}