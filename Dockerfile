FROM nginx:1-alpine
COPY ./nginx.conf /etc/nginx/templates/nginx.conf.template
RUN rm -f /etc/nginx/conf.d/default.conf
