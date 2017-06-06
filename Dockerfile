FROM python:3.6
MAINTAINER Allan Lewis <allanlewis99@gmail.com>

# Install the needed packages
RUN apt-get update
RUN apt-get install -y supervisor nginx

# Copy and set up the app
RUN mkdir /app
RUN rm -rf /app/.git
RUN rm -rf /app/.idea
RUN pip install virtualenv
COPY . /app
RUN cd /app && make clean && make

# Configure nginx
RUN mv /app/config/nginx.conf /etc/nginx/sites-available/default
RUN echo "daemon off;" >> /etc/nginx/nginx.conf 

# Configure supervisor
RUN mv /app/config/supervisor.conf /etc/supervisor/conf.d/

EXPOSE 8080
CMD ["supervisord", "-n"]
