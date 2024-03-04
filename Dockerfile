# Use an official Python runtime
FROM python:3.12-bookworm

# Allows docker to cache installed dependencies between builds
COPY requirements.txt requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# Copy application code to image
COPY . code
WORKDIR /code

EXPOSE 8000

# runs the production server
COPY ./entrypoint.sh /code/entrypoint.sh
RUN chmod +x /code/entrypoint.sh

ENTRYPOINT ["/code/entrypoint.sh", "db", "python", "manage.py", "runserver", "0.0.0.0:8000"]