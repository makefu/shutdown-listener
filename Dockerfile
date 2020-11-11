# use python slim-debian
FROM python:slim

# create run user
RUN useradd -c "docker user" -d /usr/src/app -m -u 1000 -U docker

# chown workdir
RUN chown 1000:1000 /usr/src/app
RUN chmod 755 /usr/src/app

# make homedir to docker workdir
WORKDIR /usr/src/app

# specify user to use
USER docker

# copy listener script
COPY listen.py ./

# copy over pip req file
COPY requirements.txt ./

# copy listener-scripts
COPY listener-scripts /usr/src/app/listener-scripts

# switch to root for sudo tasks
USER root

# use pip req file
RUN pip install --no-cache-dir -r requirements.txt

# install powershell and gss-ntlmssp
RUN apt-get update && \
    apt-get install -y wget

RUN wget https://packages.microsoft.com/config/debian/10/packages-microsoft-prod.deb && \
    dpkg -i packages-microsoft-prod.deb && \
    apt-get update && \
    apt-get install --yes powershell gss-ntlmssp && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists

# specify user to use
USER docker

EXPOSE 2342/udp

CMD [ "python", "/usr/src/app/listen.py", "./listener-scripts" ]
