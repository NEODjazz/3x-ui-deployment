### Variables
COMPOSE_PROJECT=3x-ui
COMPOSE_FILE=docker-compose.yml

### Install packages
sudo apt-get update -y
sudo apt install -y mawk grep qrencode ca-certificates curl


# remove old docker packages
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do sudo apt-get remove $pkg; done

# add docker repo

sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y

# install docker
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin


### Create File System
mkdir -p /opt/$COMPOSE_PROJECT/db
mkdir -p /opt/$COMPOSE_PROJECT/cert

cp /opt/$COMPOSE_FILE /opt/$COMPOSE_PROJECT/

### Start 3X-UI

cd /opt/$COMPOSE_PROJECT/
docker compose pull
docker compose up -d
sleep 3
echo -n "Compose Status: "
docker compose ps | grep $COMPOSE_PROJECT | awk '{print $8 " " $9 " " $10}' 
#echo
docker compose logs $COMPOSE_PROJECT | grep "Web server running" | awk '{print $10}'