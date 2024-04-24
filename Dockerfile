FROM jacobalberty/firebird:2.5-sc

ENV CAMINHO_BD=35.247.196.95:/home/youtube/delivery/database/PRINCIPAL.FDB
ENV DB_USER=SYSDBA
ENV DB_PASS=masterkey
ENV HOSTNAME=0.0.0.0

RUN apt-get update -y && apt upgrade -y && apt-get dist-upgrade -y
RUN apt-get install -y joe wget p7zip-full curl openssh-server build-essential zlib1g-dev libcurl4-gnutls-dev 
RUN apt-get install -y libncurses5


COPY ./servidor_delivery ./servidor_delivery

EXPOSE 8080

ENTRYPOINT ./servidor_delivery