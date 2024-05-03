<?php
require_once 'vendor/autoload.php';
spl_autoload_register(function ($class) {
    $file = str_replace('\\', DIRECTORY_SEPARATOR, $class).'.php';
    if (file_exists($file)) {
        require $file;
        return true;
    }
    return false;
});

use core\frontend;
use core\responseType;
use Pecee\SimpleRouter\SimpleRouter;

/* Load external routes file */
require_once 'routes.php';

//http_send_content_type("text/json");
header("Content-Type: text/json");

SimpleRouter::setDefaultNamespace('\controllers');

try {
// Start the routing
    SimpleRouter::start();
} catch(\core\propertyException $ex) {
    echo frontend::getInstance()->getErrorJson(responseType::InvalidProperty, [
        'data' => $ex->getMessage()
    ]);
} catch (\Exception $ex) {
    echo frontend::getInstance()->getErrorJson(responseType::InternalError, [
        'data' => $ex->getMessage()
    ]);
}