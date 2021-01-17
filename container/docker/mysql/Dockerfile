FROM docker.io/richxsl/rhel7  
ENV MYSQL_BASE_DIR=MySQL5.7_1
RUN useradd -m user
WORKDIR /home/user
RUN echo `date` start 
RUN mkdir $MYSQL_BASE_DIR
#COPY --chown=user:user .  $MYSQL_BASE_DIR
COPY .  $MYSQL_BASE_DIR
RUN pwd
RUN whoami
RUN who
# not effect ?
RUN chown user:user -R $MYSQL_BASE_DIR
RUN ls -lh $MYSQL_BASE_DIR
COPY .bash_profile /home/user/
RUN pwd
RUN rm $MYSQL_BASE_DIR/Dockerfile
RUN echo `date` finish
