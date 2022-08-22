# weatherapi-gateway

Use an nginx reverse proxy as an API gateway to WeatherAPI.com

## Thoughts

- We'll be using [Weather API](https://www.weatherapi.com/docs/)
- We can use nginx for a reverse proxy

- Today is Monday, August 22, 2022 and the time is 3:50 pm EDT. We have 2 hours to complete this project.
- Let's begin by creating an nginx server in Docker.
- Next, we'll set up a simple [reverse proxy in nginx](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
- Actually, before we do that, let's put the nginx.conf file where it belongs
  - nginx.conf is in the /etc/nginx/conf.d directory, but [some tutorials](https://aws.amazon.com/getting-started/hands-on/setup-an-nginx-reverse-proxy/) suggest the templates directory instead (makes sense)
