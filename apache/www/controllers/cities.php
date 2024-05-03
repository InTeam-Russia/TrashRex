<?php

namespace controllers;

use core\frontend;
use core\propertyException;
use models\city;
use models\product;

class cities
{
    /**
     * Получает массив городов
     * @return string массив городов
     * @throws \Exception
     */
    public function all() {
        $result = city::getAll();
        echo frontend::getInstance()->getResponseJson($result);
    }

    public function get($id) {
        if(!ctype_digit($id)) {
            throw new \Exception("Некорректный id города");
        }
        echo frontend::getInstance()->getResponseJson(city::get((int)$id));
    }

    public function search() {
        if(!isset($_GET['name'])) {
            throw new propertyException('Пустой поисковый запрос');
        }
        $citiesCount = city::searchCount($_GET['name']);

        $pagination = false;

        $perPage = 25;
        if(isset($_GET['per_page'])) {
            if(!ctype_digit($_GET['per_page'])) {
                throw new propertyException("Количество городов на страницу должно являться числом.");
            }
            $perPage = (int)$_GET['per_page'];
            if($perPage < 1) {
                throw new propertyException("Количество городов должно являться положительным числом");
            }
        }

        $pagesCount = ceil($citiesCount / $perPage);
        $page = 1;
        if(isset($_GET['page'])) {
            $pagination = true;
            if(!ctype_digit($_GET['page']) || (int)($_GET['page']) < 1 || (int)($_GET['page']) > $pagesCount) {
                throw new propertyException("Неправильный номер страницы");
            }
            $page = (int)$_GET['page'];
        }

        $result = [
            'total_cities'   => $citiesCount,
            'result'         => city::search($_GET['name'], $pagination, $page, $perPage)
        ];
        if($pagination) {
            $result['total_cities'] = $pagesCount;
        }
        echo frontend::getInstance()->getResponseJson($result);
    }
}