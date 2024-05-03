<?php
use Pecee\SimpleRouter\SimpleRouter;
use Pecee\Http\Request;
use core\frontend;
use core\responseType;

// https://github.com/skipperbent/simple-php-router/tree/master?tab=readme-ov-file#getting-restresource-controller-urls

/*SimpleRouter::get('/', function() {
    $front = frontend::getInstance();
    echo $front->getResponseJson(["messaage" => "Hello world"]);
});*/

//SimpleRouter::controller('/images', 'ImagesController');
SimpleRouter::post('/products/add', [\controllers\products::class, 'add']);
SimpleRouter::get('/products/{id}', [\controllers\products::class, 'get']);

SimpleRouter::get('/categories/all', [\controllers\categories::class, 'getAllCategories']);
SimpleRouter::get('/categories/exists/{id}', [\controllers\categories::class, 'categoryExists']);
SimpleRouter::get('/categories/find/{name}', [\controllers\categories::class, 'find']);
SimpleRouter::get('/categories/{id}', [\controllers\categories::class, 'getCategory']);

SimpleRouter::get('/cities/all', [\controllers\cities::class, 'all']);
SimpleRouter::get('/cities/search', [\controllers\cities::class, 'search']);
SimpleRouter::get('/cities/{id}', [\controllers\cities::class, 'get']);

SimpleRouter::get('/auth/whoami', [\controllers\auth::class, 'whoami']);

SimpleRouter::post('/infrastructure/storage/{city_id}', [\controllers\infrastructure::class, 'addStorage']);
SimpleRouter::post('/infrastructure/delivery_point/{city_id}', [\controllers\infrastructure::class, 'addDeliveryPoint']);
SimpleRouter::delete('/infrastructure/storage/{city_id}', [\controllers\infrastructure::class, 'removeStorage']);
SimpleRouter::delete('/infrastructure/delivery_point/{city_id}', [\controllers\infrastructure::class, 'removeDeliveryPoint']);
SimpleRouter::get('/infrastructure/', [\controllers\infrastructure::class, 'get']);

SimpleRouter::error(function(Request $request, \Exception $exception) {
    $front = frontend::getInstance();
    switch($exception->getCode()) {
        // Page not found
        case 404:
            echo $front->getErrorJson(responseType::InvalidMethod);
            break;
        // Forbidden
        case 403:
            echo $front->getErrorJson(responseType::NoAccess);
            break;
    }

});