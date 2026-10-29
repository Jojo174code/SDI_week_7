FROM python:3.13-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY app ./app

EXPOSE 8501

# Create non-root application user
RUN useradd --create-home --uid 10001 appuser && chown -R appuser:appuser /app

# Run as non-root
USER appuser

CMD ["streamlit", "run", "app/main.py", "--server.address=0.0.0.0", "--server.port=8501"]
