# using official python 3.7 image
FROM python:3.7

# installing packages
RUN pip install --upgrade pip

# declaring label
LABEL Name=ca-project Version=1.0

# declaring work directory
WORKDIR /app
COPY . /app

# running main script
ENTRYPOINT ["python", "run.py"]