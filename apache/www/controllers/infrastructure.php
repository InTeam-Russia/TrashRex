<?php

namespace controllers;

use core\frontend;
use core\pagination;
use core\propertyException;
use core\responseType;
use models\city;
use models\company;
use models\user;

class infrastructure
{

    use pagination;

    /**
     * Проверяет входные данные (авторизация и id города), загружает модель инфраструктуры в данном городе. В случае ошибки возвращает null
     * @param mixed $city_id
     * @return \models\infrastructure|null
     * @throws \Exception
     */
    public function checkInputAndLoadInfrastructure(mixed $city_id) : ?\models\infrastructure {
        $frontend = frontend::getInstance();
        $me = user::getMe();
        if(is_null($me)) {
            echo $frontend->getErrorJson(responseType::NotAuthorized, [
                'data' => 'Требуется авторизация'
            ]);
            return null;
        }
        if(!$me->isCompany()) {
            echo $frontend->getErrorJson(responseType::NoAccess, [
                'data' => 'Только компании могут обладать собственной инфраструктурой'
            ]);
            return null;
        }
        if(!(ctype_digit($city_id) && city::exists($city_id = (int)$city_id))) {
            echo $frontend->getErrorJson(responseType::NotFound, [
                'data' => 'Город не найден'
            ]);
            return null;
        }
        $company_id = $me->id;
        $infrastructure = \models\infrastructure::getInstance($company_id, $city_id);
        return $infrastructure;
    }

    /**
     * Добавляет склад
     * @param mixed $city_id id города
     * @return void
     * @throws \Exception
     */
    public function addStorage(mixed $city_id): void
    {
        $frontend = frontend::getInstance();
        $infrastructure = $this->checkInputAndLoadInfrastructure($city_id);
        if(is_null($infrastructure)) {
            return;
        }
        $infrastructure->createStorage();
        echo $frontend->getResponseJson([
            'data' => 'Склад добавлен'
        ]);
    }

    /**
     * Удаляет склад
     * @param mixed $city_id id города
     * @return void
     * @throws \Exception
     */
    public function removeStorage(mixed $city_id): void
    {
        $frontend = frontend::getInstance();
        $infrastructure = $this->checkInputAndLoadInfrastructure($city_id);
        if(is_null($infrastructure)) {
            return;
        }
        $infrastructure->removeStorage();
        echo $frontend->getResponseJson([
            'data' => 'Склад удалён'
        ]);
    }

    /**
     * Создаёт пункт выдачи
     * @param mixed $city_id id города
     * @return void
     * @throws \Exception
     */
    public function addDeliveryPoint(mixed $city_id): void
    {
        $frontend = frontend::getInstance();
        $infrastructure = $this->checkInputAndLoadInfrastructure($city_id);
        if(is_null($infrastructure)) {
            return;
        }
        $infrastructure->createDeliveryPoint();
        echo $frontend->getResponseJson([
            'data' => 'Пункт выдачи добавлен'
        ]);
    }

    /**
     * Удаляет пункт выдачи
     * @param mixed $city_id id города
     * @return void
     * @throws \Exception
     */
    public function removeDeliveryPoint(mixed $city_id): void
    {
        $frontend = frontend::getInstance();
        $infrastructure = $this->checkInputAndLoadInfrastructure($city_id);
        if(is_null($infrastructure)) {
            return;
        }
        $infrastructure->removeDeliveryPoint();
        echo $frontend->getResponseJson([
            'data' => 'Пункт выдачи удалён'
        ]);
    }

    /**
     * Получает инфраструктуру согласно фильтрам. Возможна пагинация
     * @return void
     * @throws propertyException
     */
    public function get() : void {
        $filters = [];
        if(isset($_GET['company_id'])) {
            if(!(ctype_digit($_GET['company_id']) && company::exists((int)$_GET['company_id']))) {
                throw new propertyException("Некорректная компания");
            }
            $filters['company_id'] = (int)$_GET['company_id'];
        }
        if(isset($_GET['city_id'])) {
            if(!(ctype_digit($_GET['city_id']) && city::exists((int)$_GET['city_id']))) {
                throw new propertyException("Некорректный город");
            }
        } else if(!isset($_GET['company_id'])) {
            throw new propertyException("Необходимо задать хотя бы один фильтр");
        }
        $perPage = $this->checkAmountPerPage(100);
        $infrastructureCount = \models\infrastructure::filteredSearchCount($filters);
        $pagesCount = ceil($infrastructureCount / $perPage);
        $page = $this->getPageNumber($pagesCount);
        $result = \models\infrastructure::filteredSearch($filters, $page != 0, $page, $perPage);
        echo frontend::getInstance()->getResponseJson([
            'total_pages'    => $pagesCount,
            'total_found'    => $infrastructureCount,
            'result'         => $result
        ]);
    }
}