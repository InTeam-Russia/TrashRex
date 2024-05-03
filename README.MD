# Логистическая платформа
## Поднятие сервера
Пересобрать проект (если необходимо):
```
docker-compose build
```

Запустить оркестр:
```
docker-compose run
```

## Данные для доступа
IP-адреса (для Артёма и Дани):
- 10.1.0.100:8002 -- FastAPI
- 127.0.0.1:80 -- ReactJS
- 10.1.0.102:15432 -- pgAdmin 4
- 10.1.0.100:5432 -- postegres
- 10.1.0.103:8080 -- Apache

IP-адреса (для Роберта):
- 127.0.0.1:80 -- сервер ReactJS
- 127.0.0.1:8002 -- сервер FastAPI
- 127.0.0.1:8080 -- сервер Apache (для php)

Данные для БД:
- user: postgres
- password: postgres
- db: logistic

Данные для pgAdmin:
- email: admin@pgadmin.com
- password: 123456


## API

Коды ответа:
- ``` 200 ``` -- запрос выполнен успешно
- ``` 400 ``` -- обращение к несуществующему методу или с некорректными параметрами
- ``` 401 ``` -- для выполнения запроса требуется авторизация
- ``` 403 ``` -- нет прав для выполнения запроса (напр., пользователь пытается выполнить запрос, доступный только для компании)
- ``` 404 ``` -- данные не найдены
- ``` 500 ``` -- всё, пока, сервер упал

### Методы Python API
#### auth/is_authorized
Запрос:
```
GET /auth/is_authorized
```

Ответ:
1. Если пользователь не авторизован:
```
401 Unauthorized
{"details": "Unauthorized"}

```

2. Если пользователь авторизован:
```
200 OK
{"id": айдишник, "role": роль}
```

### Методы php API
#### auth/whoami
Запрос:
```
GET /auth/whoami
```
Ответ:
1. Если пользователь не авторизован:
```
200 OK
{ "role": "guest" }
```

2. Если авторизован клиент:
```
200 OK
{
	"id": айдишник,
	"email": "почта",
	"role": "client",
	"data": {
		"name": "имя",
		"surname": "фамилия",
		"img": "путь к аватарке"
	}
}
```

3. Если авторизована компания:
```
200 OK
{
        "id": айдишник,
        "email": "почта",
	"role": "company",
	"data": {
		"name": "название",
		"img": "путь к аватарке"
	}
}
```

#### /categories/{id}
Запрос:
```
GET /categories/{id}
```

1. Ответ:
```
200 OK
{
	"id": айдишник,
	"name": "Название категории",
	"icon": true/false
}
```
2. Ответ в случае подачи айдишника несуществующей категории
```
404 Not found
{
	"data": "Категория не существует"
}
```
3. Ответ в случае ошибки иного рода
```
500 Internal server error
{
	"data": "Описание ошибки"
}
```

#### /categories/all
Отдаёт массив всех категорий.
Запрос:
```
GET /categories/all
```
Ответ:
```
[
	{
		"id": айдишник, "name": название категории", "icon: true/false
	},
	...
]
```

#### /categories/exists/{id}
Проверяет, существует ли категория с заданным id
Запрос:
```
GET /categories/exists/{id}
```
Ответ:
```
{
	"result": true/false
}
```

#### /categories/find/{name}
Выполняет поиск по имени категории. Запрос:
```
GET /categories/find/азн
```

Ответ:
```
200 OK
[
    {
        "id": 1,
        "name": "Разное",
        "icon": false
    }
]
```

#### /products/add
Добавляет продукт (метод для компаний).
Запрос:
```
PUT /products/add
{
	"name": "Имя продукта (обязательный параметр)",
	"price": 300.69,
	"amount": 1488
}
```
Обязательные параметры: name (string, имя продукта), price (double, цена), amount (int, количество)
Дополнительные параметры: size (string в формате "5см x 5см x 5см"), img (файл изображения), category (int, id категории)

Ответ:
1. id созданного продукта:
```
200 OK
{ "id": 213 }
```

2. Требуется авторизация
```
401 Unauthorized
[]
```

3. Недостаточно прав (пользователь является клиентом, а не компанией)
```
403 Forbidden
[]
```

#### /products/{id}
Общедоступный метод, возвращает информацию о продукте.
Запрос:
```
GET /products/{id}
```

Ответ:
```
200 OK
{
    "id": 1,
    "company_id": 1,
    "name": "Интим",
    "price": 300000,
    "amount": 0,
    "size": "69 см x 300 см x 1488 см",
    "img": null,
    "category": 1,
    "hidden": true,
    "rating": null
}
```
Ответ в случае ошибки:
```
500 Internal server error
{
        "data": "Описание ошибки"
}
```

#### /catalog/search
Получает список товаров с постраничной пагинацией. К списку каталогов можно применять разнообразные фильтры в виде GET-параметров. Все GET-параметры являются опциональными, по умолчанию выводится первая страница общего каталога со всеми товарами. Запрос:
```
GET /catalog/search?фильтры

```
Доступные фильтры:
- company_id - товары конкретной компании
- category - товары конкретной категории
- max_price, min_price - диапазон цен
- max_amount, min_amount - диапазон количества в наличии
- name - название
- page - номер страницы (счёт ведётся с 1)
- per_page - товаров на страницу (в отрезке [1;25])

Ответ:
```
{
    "total_pages": 1,
    "total_products": 1,
    "result": [
        {
            "id": 1,
            "company_id": 1,
            "name": "Интим",
            "price": 300000,
            "amount": 0,
            "size": "69 см x 300 см x 1488 см",
            "img": null,
            "category": 1,
            "hidden": true,
            "rating": null
        }
    ]
}
```

- `total_pages` - всего страниц
- `total_products` - всего найденных товаров
- `result` - массив с товарами (см. /products/{id})

#### /cities/all
Получает массив городов. Запрос:
```
GET /cities/all
```

Ответ:
```
[
    {
        "id": 1,
        "name": "Абаза",
        "arms": "/public/cities/25px-Coat_of_Arms_of_Abaza_%28Khakassia%29.webp"
    },
    ...
]
```
#### /cities/search
Выполняет поиск по городам. Запрос:
```
GET /cities/search
name=атов
```

Ответ:
```
200 OK
{
    "total_cities": 8,
    "result": [
        {
            "id": 42,
            "name": "Ардатов",
            "arms": "/public/cities/25px-Coat_of_Arms_of_Ardatov_%282011%29.webp"
        },
        {
            "id": 226,
            "name": "Горбатов",
            "arms": "/public/cities/25px-Gorbatov_COA_%28Nizhny_Novgorod_Governorate%29_%281781%29.webp"
        },
        {
            "id": 256,
            "name": "Далматово",
            "arms": "/public/cities/25px-Coat_of_Arms_of_Dalmatovo_%282006%29.webp"
        },
        {
            "id": 372,
            "name": "Ипатово",
            "arms": "/public/cities/25px-Coat_of_arms_of_Ipatovsky_rayon_%28Stavropol_krai%29.svg.webp"
        },
        {
            "id": 498,
            "name": "Красноармейск (Саратовская область)",
            "arms": "/public/cities/25px-Coat_of_Arms_of_Krasnoarmeysk_%28Saratov_oblast%29.webp"
        },
        {
            "id": 544,
            "name": "Курчатов",
            "arms": "/public/cities/25px-Coat_of_Arms_of_Kurchatov_%28Kursk_oblast%29.webp"
        },
        {
            "id": 889,
            "name": "Саратов",
            "arms": "/public/cities/25px-Coat_of_Arms_of_Saratov.webp"
        },
        {
            "id": 896,
            "name": "Сватово",
            "arms": "/public/cities/Coat_of_arms_of_Lugansk_People%27s_Republic.svg/261px-Coat_of_arms_of_Lugansk_People%27s_Republic.svg.webp"
        }
    ]
}
```
#### /cities/{id}
Получает информацию о городе по id. Запрос:
```
GET /ctites/{id}
```

Ответ:
```
{
    "id": 889,
    "name": "Саратов",
    "arms": "/public/cities/25px-Coat_of_Arms_of_Saratov.webp"
}
```

#### /infrastructure/
Выполняет поиск по инфраструктуре. Совместимо с пагинацией. Запрос:
```
GET /infrastructure/
company_id=айдишник_компании
city_id=айдишник_города
page=1
per_page=число_от_1_до_100
```
Все параметры являются необязательными, но хотя бы один фильтр (```company_id``` или ```city_id```) обязан быть применён.

Ответ:
```
{
    "total_pages": страниц,
    "total_found": результатов,
    "result": [
        {
            "company_id": компания,
            "city": город,
            "storage": true/false,
            "dp": true/false
        }
    ]
}
```



#### /infrastructure/{type}/{city_id}
Может быть выполнено только компнаией. Добавляет или удаляет инфраструктуру заданного типа в заданном городе.
HTTP-глаголы:
- ```POST``` добавляет инфраструктуру
- ```DELETE``` удаляет инфраструктуру
Типы инфраструктуры:
- ```storage``` - склад
- ```delivery_point``` - пункт выдачи
Запрос:
```
DELETE /infrastructure/delivery_point/889
```

Ответ:
```
{
    "data": "Пункт выдачи удалён"
}
```
