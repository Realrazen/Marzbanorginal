FROM python:3.12-slim

ENV PYTHONUNBUFFERED=1
WORKDIR /code

# نصب وابستگی‌های سیستمی + Xray
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl unzip ca-certificates \
    && curl -L https://github.com/XTLS/Xray-install/raw/main/install-release.sh | bash \
    && rm -rf /var/lib/apt/lists/*

# کپی کردن فایل‌های پروژه
COPY requirements.txt .
RUN pip install --upgrade pip "setuptools<81" \
    && pip install --no-cache-dir -r requirements.txt

COPY . .

# اجرای مایگریشن و استارت
CMD ["bash", "-c", "alembic upgrade head && python main.py"]
