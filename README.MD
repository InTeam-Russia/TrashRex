# TrashRex
## Поднятие сервера
```
docker compose build
docker compose up
chmod +x ./restore_database.sh
./restore_database.sh
npm run start
```

## Данные для доступа
IP-адреса:
- __127.0.0.1:80__ -- фронтенд React
- 10.1.0.100:8000 -- бекенд FastAPI
- 10.1.0.100:5432 -- postegres

Данные для БД:
- user: postgres
- password: postgres
- db: trash
