# weatherapi-gateway

Use an nginx reverse proxy as an API gateway to WeatherAPI.com

## Usage

First, get a WeatherAPI.com account and generate an API key. The following commands
assume that you have stored the API key in the environment variable `WEATHER_API_KEY`
and that Docker is installed and the engine is running.

**Please note:** if you use the `zsh` shell (default on recent macOS installations),
the URL _must_ be enclosed in double quotes.

```bash
docker build -t weather_proxy:latest .
docker run -e WEATHER_API_KEY=$WEATHER_API_KEY -p 80:80 weather_proxy:latest
curl "localhost:80/v1/current.json?q=10014&aqi=no"
```

## Thoughts

- We'll be using [Weather API](https://www.weatherapi.com/docs/)
- We can use nginx for a reverse proxy

- Today is Monday, August 22, 2022 and the time is 3:50 pm EDT. We have 2 hours to complete this project.
- Let's begin by creating an nginx server in Docker.
- Next, we'll set up a simple [reverse proxy in nginx](https://docs.nginx.com/nginx/admin-guide/web-server/reverse-proxy/)
- Actually, before we do that, let's put the nginx.conf file where it belongs
  - nginx.conf is in the /etc/nginx/conf.d directory, but [some tutorials](https://aws.amazon.com/getting-started/hands-on/setup-an-nginx-reverse-proxy/) suggest the templates directory instead (makes sense)
- Now we'll actually configure the reverse proxy
- Reverse proxy configured, but changes aren't appearing... still redirected to default nginx home page
  - Copying nginx.conf to /etc/nginx.conf doesn't help either
  - There are four different nginx configuration files in /etc:
    - /etc/nginx.conf
    - /etc/nginx/conf.d/default.conf
    - /etc/nginx/conf.d/nginx.conf
    - /etc/nginx/templates/nginx.conf
  - `nginx/templates/nginx.conf` is the same as `nginx.conf`
  - `nginx.conf` looks compatible with our configuration
  - `nginx/conf.d/default.conf` problematic? likely!
- `default.conf` seems safe to delete entirely, and doing so moves us forward!

- Time is now 4:24 pm EDT (5:50 pm is deadline)
  - localhost:80 gives 200 OK with message `All OK`
  - localhost:80/v1/current.json gives `{"error":{"code":1002,"message":"API key is invalid or not provided."}}`
    - Makes sense, since we haven't provided an API key yet
- We can begin by passing the API key as an environment variable through Docker's ENV instruction
  - [Weather API docs](https://www.weatherapi.com/docs/)
  - Weather API's [authentication docs](https://www.weatherapi.com/docs/#intro-authentication) recommend
    using `key=<YOUR API KEY>` as a query parameter, but passing secrets in the URL isn't a good idea.
    It would also be hard to append that query parameter to the `proxy_pass` URL (consider `?` vs `&` in URLs),
    and regex doesn't feel like a proper solution here.
  - Can we provide the query parameter in the headers or body of the request instead?
    - At least in this case, yes we can! Just name the header "key" and set the value to the API key.
- Time is now 4:44 pm EDT
  - <localhost:80> gives 200 OK with message `All OK`
  - <localhost:80/v1/current.json> gives `{"error":{"code":1003,"message":"Parameter q is missing."}}`
  - <localhost:80/v1/current.json?q=10014&aqi=no> gives `{"location":{"name":"New York",[...]}}`
    - Great!
