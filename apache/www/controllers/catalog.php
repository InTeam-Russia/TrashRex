<?php

namespace controllers;

use core\frontend;
use core\pagination;
use core\propertyException;
use models\category;
use models\company;
use models\product;

class catalog
{
    use pagination;

    /**
     * проверяет корректность id категории и возвращает его
     * @return int|null id категории или null, если выборка по категории не требуется
     * @throws propertyException Ожидался id категории
     * @throws propertyException Категория с таким id не существует
     */
    private function checkCategory() : ?int {
        if(isset($_GET['category'])) {
            if (!is_numeric($_GET['category'])) {
                throw new propertyException('Ожидался id категории');
            }
            $id = (int)$_GET['category'];
            if (!category::exists($id)) {
                throw new propertyException('Категория с таким id не существует');
            }
            return $id;
        }
        return null;
    }

    /**
     * проверяет id компании и возвращает его
     * @return int|null id компании или null, если выборка по компании не требуется
     * @throws propertyException Ожидался id компании
     * @throws propertyException Компании с таким id не нашлось
     */
    private function checkCompany() : ?int {
        if(isset($_GET['company'])) {
            if(!is_numeric($_GET['company'])) {
                throw new propertyException('Ожидался id компании');
            }
            $id = (int)$_GET['company'];
            if(!company::exists($id)) {
                throw new propertyException('Компании с таким id не нашлось');
            }
            return $id;
        }
        return null;
    }

    /**
     * Проверяет корректность цены товара
     * @param string $tag ключ в массиве $_GET
     * @return float|null цена товара или null
     * @throws propertyException Цена должна являться целым или дробным неотрицательным числом, а не этим вот всем
     */
    private function checkPrice(string $tag) : ?float {
        if(isset($_GET[$tag])) {
            if(!is_numeric($_GET[$tag]) || (float)$_GET[$tag] < 0) {
                throw new propertyException('Цена ' . $tag . ' должна являться целым или дробным неотрицательным числом, а не этим вот всем');
            }
            return (float)$_GET[$tag];
        }
        return null;
    }

    /**
     * Проверяет корректность количества товара
     * @param string $tag ключ в массиве $_GET
     * @return int|null количество товара или null
     * @throws propertyException Количество должно являться целым неотрицательным числом, а не этим вот всем
     */
    private function checkAmount(string $tag) : ?int {
        if(isset($_GET[$tag])) {
            if(!is_int($_GET[$tag]) || (int)$_GET[$tag] < 0) {
                throw new propertyException('Количество ' . $tag . ' должно являться целым неотрицательным числом, а не этим вот всем');
            }
            return (int)$_GET[$tag];
        }
        return null;
    }

    /**
     * Получает товары с текущей страницы пагинации
     * @return void
     * @throws propertyException
     */
    public function search() {
        $allFilters = [
            'company_id'   => $this->checkCompany(),
            'category'     => $this->checkCategory(),
            'min_price'    => $this->checkPrice('min_price'),
            'max_price'    => $this->checkPrice('max_price'),
            'min_amount'   => $this->checkAmount('min_amount'),
            'max_amount'   => $this->checkAmount('max_amount'),
            'name'         => $_GET['name']
        ];
        $filters = array_filter($allFilters, function($value) {
            return !is_null($value);
        });
        $perPage = $this->checkAmountPerPage(25);
        $productsCount = product::filteredSearchCount($filters);
        $pagesCount = ceil($productsCount / $perPage);
        $page = $this->getPageNumber($pagesCount);
        $result = product::filteredSearch($filters, $page, $perPage);
        echo frontend::getInstance()->getResponseJson([
            'total_pages'    => $pagesCount,
            'total_products' => $productsCount,
            'result'         => $result
        ]);
    }
}