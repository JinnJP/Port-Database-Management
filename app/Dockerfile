FROM python:3.9
EXPOSE 4999
WORKDIR /app
COPY requirements.txt /app
RUN pip install -r requirements.txt
COPY app.py /app
# controller.py is a custom module
COPY controller.py /app 
CMD python app.py