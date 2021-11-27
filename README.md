# Ender-Woods-Nakama-Server
This is a reimplementation of the Auth server using nakama

## Install latest verion of docker compose
Linux - 
```
sudo curl -L "https://github.com/docker/compose/releases/download/`curl -fsSLI -o /dev/null -w %{url_effective} https://github.com/docker/compose/releases/latest | sed 's#.*tag/##g' && echo`/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
```

## Windows - 

#### How to start server
`docker compose up`
#### How to contribute
 - Suggest to use VScode for code editing
 - This requires npm
#### How to test your changes
 - `docker compose down`
 - `docker compose build` // this rebuilds the typescript and updates the javascript module for nakama
 - `docker compose up`
 - Either use the test app or open nakama console at `localhost:7351`. it uses default credentials `admin:password`.
 You can execute rpcs through "Explore Api"
#### Troubleshooting
##### 1. My changes are not updated, new rpcs arent visible
Most likely typescript didn't compile correctly

## Linux 

Same as above except use `docker-compose` instead of `docker compose`

----------------------------------------------------------------------------

## If setting up Docker for the first time on a new linux machine 

#### Remove any old versions

```sudo apt-get remove docker docker-engine docker.io containerd runc```

#### Set up the Repo

```
 sudo apt-get update

 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

#### Add Dockers official GPG Key:

```
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

#### Get the stable repo

```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

#### Install Docker Engine

```
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

```

### To install a specific version of docker

#### List the versions
```
apt-cache madison docker-ce

docker-ce | 5:18.09.1~3-0~ubuntu-xenial | https://download.docker.com/linux/ubuntu  xenial/stable amd64 Packages
```

#### Install the specific version
```
sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io

eg: sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=5:18.09.1~3-0~ubuntu-xenial containerd.io
```

#### Check Version
```
sudo docker -version
```

## To log in to the testing dedicated server

#### SSH in from the terminal
```
ssh root@45.58.43.202
```
If you are supposed to have access you will know the password. 

Navigate to `/home/godot` to find all the files.

#### To upload a file to the server
```
scp file_name root@45.58.43.202:/home/godot

eg: scp world.pck root@45.58.43.202:/home/godot
```
