FROM ubuntu/apache2

WORKDIR /var/www/html

RUN apt update && apt install -y git 
RUN git init && git remote add origin https://github.com/iSTKr/Symphony_test.git 
RUN git config --global user.email "didenko.anton.v@gmail.com" && git config --global user.name "iSTKr" 
RUN git pull origin main && cp -r /git/CV/* /var/www/html/

EXPOSE 80

CMD ["apachectl", "-D", "FOREGROUND"]
