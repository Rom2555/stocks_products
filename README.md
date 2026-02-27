# Stocks & Products API

Веб-приложение на Django с REST API для управления товарами и складами.

## Технологический стек

- **Django 3.2** — веб-фреймворк
- **Django REST Framework** — REST API
- **PostgreSQL** — база данных

## Структура проекта

```
stocks_products/
├── manage.py
├── requirements.txt
├── stocks_products/        # Основной конфигурационный модуль
│   ├── settings.py         # Настройки Django
│   ├── urls.py             # Корневые URL
│   ├── wsgi.py
│   └── asgi.py
└── logistic/               # Приложение для управления товарами и складами
    ├── models.py           # Модели: Product, Stock, StockProduct
    ├── views.py            # ViewSets для API
    ├── serializers.py      # Сериализаторы DRF
    ├── urls.py             # URL-маршруты
    └── migrations/         # Миграции БД
```

## Модели данных

### Product
Товар с названием и описанием.

| Поле | Тип | Описание |
|------|-----|----------|
| id | Integer | Уникальный идентификатор |
| title | CharField(60) | Название товара |
| description | TextField | Описание товара |

### Stock
Склад с адресом.

| Поле | Тип | Описание |
|------|-----|----------|
| id | Integer | Уникальный идентификатор |
| address | CharField(200) | Адрес склада |
| products | ManyToManyField | Связь с товарами через StockProduct |

### StockProduct
Промежуточная модель для связи товаров со складами.

| Поле | Тип | Описание |
|------|-----|----------|
| id | Integer | Уникальный идентификатор |
| stock | ForeignKey | Ссылка на склад |
| product | ForeignKey | Ссылка на товар |
| quantity | PositiveInteger | Количество единиц товара |
| price | DecimalField(18,2) | Цена за единицу |

## API Endpoints

### Products
- `GET /api/v1/products/` — список товаров
- `POST /api/v1/products/` — создать товар
- `GET /api/v1/products/{id}/` — получить товар
- `PATCH /api/v1/products/{id}/` — обновить товар
- `DELETE /api/v1/products/{id}/` — удалить товар
- `GET /api/v1/products/?search=...` — поиск по названию и описанию

### Stocks
- `GET /api/v1/stocks/` — список складов
- `POST /api/v1/stocks/` — создать склад с позициями
- `GET /api/v1/stocks/{id}/` — получить склад
- `PATCH /api/v1/stocks/{id}/` — обновить позиции склада
- `DELETE /api/v1/stocks/{id}/` — удалить склад
- `GET /api/v1/stocks/?products=...` — поиск складов по товару

## Установка и запуск

1. Установить зависимости:
```bash
pip install -r requirements.txt
```

2. Настроить базу данных в `stocks_products/settings.py`

3. Выполнить миграции:
```bash
python manage.py migrate
```

4. Запустить сервер:
```bash
python manage.py runserver
```

Сервер будет доступен по адресу: http://localhost:8000/api/v1/

## Примеры запросов

Примеры HTTP-запросов находятся в файле `requests-examples.http`.

### Создание товара
```http
POST /api/v1/products/
Content-Type: application/json

{
  "title": "Помидор",
  "description": "Лучшие помидоры на рынке"
}
```

### Создание склада
```http
POST /api/v1/stocks/
Content-Type: application/json

{
  "address": "ул. Ленина 1",
  "positions": [
    {
      "product": 1,
      "quantity": 100,
      "price": 50.00
    }
  ]
}
```

## Требования

- Python 3.8+
- PostgreSQL 12+
- Django 3.2
- djangorestframework
