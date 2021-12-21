# Ender-Woods-Nakama-Server
This is a reimplementation of the Auth server using nakama

#### Video Tutorial: 


https://user-images.githubusercontent.com/53924507/146849715-61165276-e9c5-422f-97f7-5c98dba2eb9a.mp4



#### Access GUI:
`localhost:7351`
[localhost:7351](http://localhost:7351)



## Setup environment
### Windows
#### Install Docker
 - https://www.docker.com/products/docker-desktop
#### Install node
 - https://nodejs.org/en/download/
### Linux
#### Install latest verion of docker compose

```
sudo curl -L "https://github.com/docker/compose/releases/download/`curl -fsSLI -o /dev/null -w %{url_effective} https://github.com/docker/compose/releases/latest | sed 's#.*tag/##g' && echo`/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose
```

Use the same as you would on windows except use `docker-compose` instead of `docker compose`

----------------------------------------------------------------------------

#### Install docker
  1. Remove any old versions

```sudo apt-get remove docker docker-engine docker.io containerd runc```

  2. Before all
```
sudo apt-get update
sudo apt upgrade
```

  3. Set up the Repo

```
 sudo apt-get update

 sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

  4. Add Dockers official GPG Key:

```
 curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

  5. Get the stable repo

```
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

  6. Install Docker Engine

```
sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli containerd.io

```

  7. (optional) To install a specific version of docker

List the versions
```
apt-cache madison docker-ce

docker-ce | 5:18.09.1~3-0~ubuntu-xenial | https://download.docker.com/linux/ubuntu  xenial/stable amd64 Packages
```

Install the specific version
```
sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=<VERSION_STRING> containerd.io

eg: sudo apt-get install docker-ce=<VERSION_STRING> docker-ce-cli=5:18.09.1~3-0~ubuntu-xenial containerd.io
```

#### Install node/npm

```
curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
```
```
sudo apt install -y nodejs
```


## Starting the server
`docker compose up` in the root repo directory
### On dedicated server
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

### How to contribute
 - Suggest to use VScode for code editing
 - run `npm install` before starting
## How to test your changes
 - `docker compose down`
 - `docker compose build` // this rebuilds the typescript and updates the javascript module for nakama
 - `docker compose up`
 - Either use the test app or open nakama console at `localhost:7351`. it uses default credentials `admin:password`.
 You can execute rpcs through "Explore Api"
## Troubleshooting
### 1. My changes are not updated, new rpcs arent visible
Most likely typescript didn't compile correctly
### 2. Something is not working
Check if your docker/npm/node versions match

```
root@EnderWoods:~# npm version
{
  npm: '8.1.4',
  node: '16.13.0',
```

```
root@EnderWoods:~# docker version
Client: Docker Engine - Community
 Version:           20.10.11
 API version:       1.41
 Go version:        go1.16.9
 Git commit:        dea9396
 Built:             Thu Nov 18 00:37:06 2021
 OS/Arch:           linux/amd64
 Context:           default
 Experimental:      true

Server: Docker Engine - Community
 Engine:
  Version:          20.10.11
  API version:      1.41 (minimum version 1.12)
  Go version:       go1.16.9
  Git commit:       847da18
  Built:            Thu Nov 18 00:35:15 2021
  OS/Arch:          linux/amd64
  Experimental:     false
 containerd:
  Version:          1.4.12
  GitCommit:        7b11cfaabd73bb80907dd23182b9347b4245eb5d
 runc:
  Version:          1.0.2
  GitCommit:        v1.0.2-0-g52b36a2
 docker-init:
  Version:          0.19.0
  GitCommit:        de40ad0
```

```
root@EnderWoods:~# docker-compose version
Docker Compose version v2.1.1
```

#### API for databases

http://127.0.0.1:7350/v2/rpc/get_crafting_recipes_database?http_key=defaulthttpkey

http://127.0.0.1:7350/v2/rpc/get_items_database?http_key=defaulthttpkey

http://127.0.0.1:7350/v2/rpc/get_item_modifiers_database?http_key=defaulthttpkey

http://127.0.0.1:7350/v2/rpc/get_quests_database?http_key=defaulthttpkey

Will obviously remove thiw when it matters
