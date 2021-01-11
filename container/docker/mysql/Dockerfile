FROM docker.io/richxsl/rhel7  
ENV MYSQL_BASE_DIR=MySQL5.7_1
RUN pwd
RUN useradd -m user
WORKDIR /home/user
RUN echo `date` start 
RUN mkdir $MYSQL_BASE_DIR
COPY .  $MYSQL_BASE_DIR
RUN pwd
RUN ls $MYSQL_BASE_DIR
USER user
COPY .bash_profile /home/user/
RUN echo `date` finish
