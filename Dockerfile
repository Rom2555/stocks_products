FROM python:3.9-slim

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем файл с зависимостями
COPY requirements.txt .

# Устанавливаем зависимости
RUN pip install --no-cache-dir -r requirements.txt

# Копируем все файлы проекта
COPY . .

# Открываем порт 8000
EXPOSE 8000

# Запускаем приложение через WSGI сервер Gunicorn
CMD ["gunicorn", "stocks_products.wsgi:application", "--bind", "0.0.0.0:8000", "--workers", "3"]
