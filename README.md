# Ender-Woods-Nakama-Server
This is a reimplementation of the Auth server using nakama

#Install latest verion of docker compose
Linux - ```sudo curl -L "https://github.com/docker/compose/releases/download/`curl -fsSLI -o /dev/null -w %{url_effective} https://github.com/docker/compose/releases/latest | sed 's#.*tag/##g' && echo`/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose```

# How to start server
`docker compose up`
# How to contribute
 - Suggest to use VScode for code editing
 - This requires npm
# How to test your changes
 - `docker compose down`
 - `docker compose build` // this rebuilds the typescript and updates the javascript module for nakama
 - `docker compose up`
 - Either use the test app or open nakama console at `localhost:7351`. it uses default credentials `admin:password`.
 You can execute rpcs through "Explore Api"
# Troubleshooting
## 1. My changes are not updated, new rpcs arent visible
Most likely typescript didn't compile correctly
