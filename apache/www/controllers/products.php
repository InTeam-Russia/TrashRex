<?php

namespace controllers;
use core\filesystem;
use core\propertyException;
use core\responseType;
use core\singleton;
use models\category;
use models\product;
use models\user;
use core\frontend;

class products
{
    use singleton;
    public function checkName(mixed $name) : bool {
        if(!is_string($name)) {
            throw new \Exception("Имя должно являеться строкой");
        }
        if(mb_strlen($name) >= 255) {
            throw new \Exception("Слишком длинное имя");
        }
        if(empty($name)) {
            throw new \Exception("Имя не может быть пустым");
        }
        if(!preg_match("/[0-9a-zA-ZёЁА-Яа-я,.\s!+\-=_%$#№@&^';:*\"?\[\]]+/", $name)) {
            throw new \Exception("Имя содержит запрещённые символы. Разрешаются только буквы кириллицы, латиницы, знаки препинания, арифметические знаки, кавычки и квадратные скобки.");
        }
        return true;
    }

    public function checkPrice(mixed $price) : bool {
        if(!(is_numeric($price) || is_float($price))) {
            throw new \Exception("Цена должна являться целым или дробным числом");
        }
        if((int)$price < 0) {
            throw new \Exception("Цена не может быть отрицательной");
        }
        return true;
    }

/*    public function checkAmount($amount) {
        if(!is_int($amount)) {
            throw new \Exception("Количество должна быть целым числом");
        }
        if($amount < 0) {
            throw new \Exception("Количество не может быть отрицательным");
        }
        return true;
    }*/

    public function get($id) {
        $frontend = frontend::getInstance();
        if(!is_numeric($id)) {
            echo $frontend->getErrorJson(responseType::InvalidProperty, "Требуется ID продукта");
            return;
        }
        try {
            $product = product::get($id);
            echo $frontend->getResponseJson($product);
        } catch(\Exception $ex) {
            echo $frontend->getErrorJson(responseType::InternalError, ["data" => $ex->getMessage()]);
        }
    }

    public function add() {
        $user = user::getInstance();
        $frontend = frontend::getInstance();
        $whoami = $user->is_authorised();
        if(!isset($whoami['role'])) {
            echo $frontend->getErrorJson(\core\responseType::NotAuthorized);
            return;
        } else if($whoami['role'] != 'company') {
            echo $frontend->getErrorJson(\core\responseType::NoAccess);
            return;
        }
        // обязательно: name, price
        // дополнительно: size, img, category
        if(!isset($_POST['name'], $_POST['price'])) {
            echo $frontend->getErrorJson(responseType::InvalidProperty, "Не перечислены значения обязательных параметров.");
            return;
        }
        try {
            $product = new product();

            $this->checkName($_POST['name']);
            $this->checkPrice($_POST['price']);

            $product->company_id = $whoami['id'];
            $product->name = $_POST['name'];
            $product->price = (float)$_POST['price'];

            if (isset($_POST['size'])) {
                if (!is_string($_POST['size']) || empty($_POST['size']) || mb_strlen($_POST['size']) > 32) {
                    throw new propertyException("Некорректный формат размера");
                }
                $product->size = $_POST['size'];
            }
            if (isset($_POST['category'])) {
                if (!is_numeric($_POST['category']) || $_POST['category'] < 0) {
                    throw new propertyException("Некорректный номер категории");
                }
                if (!category::exists((int)$_POST['category'])) {
                    throw new propertyException("Категории с таким номером не существует");
                }
                $product->category = (int)$_POST['category'];
            }
            if(isset($_FILES['img'])) {
                $format = filesystem::mime2ext($_FILES['img']['type']);
                if(!in_array($format, ['jpg', 'jpeg', 'png', 'bmp', 'gif', 'webp'])) {
                    throw new propertyException("Поддерживаются только форматы jpg, png, bmp, gif и webp.");
                }
            }

            $id = $product->add();

            if(isset($_FILE['img'])) {
                $uploaddir = filesystem::productsBasePath . $id . '/';
                mkdir($uploaddir);
                $uploadfile = $uploaddir . md5(time() . $_FILES['userfile']['name']) . $format;
                move_uploaded_file($_FILES['userfile']['tmp_name'], $uploadfile);
                $product->img = $uploadfile;
                $product->save();
            }
            echo $frontend->getResponseJson([
                'id' => $id
            ]);
        } catch(propertyException $ex) {
            echo $frontend->getErrorJson(responseType::InvalidProperty, [
                'message' => $ex->getMessage(), 'data' => $ex->getData()
            ]);
        } catch(\Exception $ex) {
            echo $frontend->getErrorJson(responseType::InternalError, [
                'message' => $ex->getMessage()
            ]);
        }
    }
}