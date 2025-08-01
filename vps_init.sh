### Variables
VPS=YOU-VPS-IP-Address
COMPOSE_FILE=docker-compose.yml

### Copy SSH Key
ssh-copy-id root@$VPS

### Copy Project and configuration script
echo "Copy configuration files ..."
scp ./$COMPOSE_FILE root@$VPS:/opt
scp ./install.sh root@$VPS:/opt

### Install and Start 3X-UI
echo "Start deployment ..."
ssh root@$VPS "bash /opt/install.sh" 
