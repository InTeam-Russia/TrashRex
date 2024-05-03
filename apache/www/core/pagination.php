<?php
namespace core;

/**
 * Пагинация (трейт для контроллеров)
 */
trait pagination
{

    /**
     * Определяет количество результатов на страницу
     * @param int $max максимальное количество результатов на страницу
     * @return int количество результатов
     * @throws propertyException некорректное количество результатов
     */
    private function checkAmountPerPage(int $max) : int {
        $amount = $max;
        if(isset($_GET['per_page'])) {
            if(!is_int($_GET['per_page']) || (int)$_GET['per_page'] <= 0 || (int)$_GET['per_page'] > 100) {
                throw new propertyException('Количество результатов на страницу должно являться целым числом в отрезке [1, ' . $max . ']');
            }
            $amount = (int)$_GET['per_page'];
        }
        return $amount;
    }

    /**
     * @param int $pagesCount количество страниц
     * @return int номер текущей страницы
     * @throws propertyException Номер страницы должен быть целым неотрицательным числом
     * @throws propertyException Номер страницы не может быть меньше единицы или превышать общее число страниц
     */
    private function getPageNumber(int $pagesCount) : int {
        $page = 0;
        if(isset($_GET['page'])) {
            if(!is_int($_GET['page'])) {
                throw new propertyException('Номер страницы должен быть целым неотрицательным числом');
            }
            $page = (int)$_GET['page'];
            if($page <= 0 || $page > $pagesCount) {
                throw new propertyException('Номер страницы не может быть меньше единицы или превышать общее число страниц');
            }
        }
        return $page;
    }
}