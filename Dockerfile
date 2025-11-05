# 1. 選擇 Python 3.11-slim 作為基礎
FROM python:3.11-slim

# 2. 設定工作目錄
WORKDIR /app

# 3. 複製需求檔案
COPY requirements.txt .

# 4. 安裝系統依賴 (Gdal) 和 Python 套件
# (libgdal-dev 是 geopandas 和 rasterio 必需的)
RUN apt-get update && apt-get install -y \
    build-essential \
    libgdal-dev \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir -r requirements.txt

# 5. 複製您所有的 App 程式碼
COPY . .

# 6. 暴露 Hugging Face 的預設埠
EXPOSE 7860
ENV PORT=7860

# 7. 啟動 Solara App
# 將 02_sidebar.py 改成你的主檔案名稱
CMD ["solara", "run", "02_sidebar.py", "--host", "0.0.0.0", "--port", "7860"]