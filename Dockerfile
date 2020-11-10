FROM python:alpine

WORKDIR /usr/src/app

# copy listener script
COPY listen.py ./

# copy over pip req file
COPY requirements.txt ./

# use pip req file
RUN pip install --no-cache-dir -r requirements.txt

# copy listener-scripts
COPY listener-scripts /usr/src/app/listener-scripts

EXPOSE 2342/udp

CMD [ "python", "/usr/src/app/listen.py", "./listener-scripts" ]
