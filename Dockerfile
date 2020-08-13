# using official python 3.7 image
FROM python:3.7

# copying requirements.txt into current dir
COPY requirements.txt .

# installing packages
RUN pip install --upgrade pip \
    pip install -r requirements.txt

# declaring label
LABEL Name=ca-project Version=1.0

# declaring work directory
WORKDIR /app
COPY . /app

EXPOSE 5000

# running main script
ENTRYPOINT ["python", "src/run.py"]