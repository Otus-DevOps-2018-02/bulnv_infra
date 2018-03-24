# bulnv_infra
bulnv Infra repository

# Homework-4
> Доп. задание: Предложить вариант решения для подключения из консоли при помощи команды вида ssh someinternalhost из локальной консоли рабочего устройства, чтобы подключение выполнялось по алиасу someinternalhost

Оптимальным на мой взгляд будет Site-to-site VPN c роутером установленным on-site, я попытался сделать это на своей старенькой Cisco 1841 но пока безуспешно, in progress...
UPD: Site-to-site VPN настроен http://prntscr.com/iuz413
 
bastion_IP = 35.204.253.80
someinternalhost_IP = 10.164.0.3

# Homework-5

>Startup скрипт необходимо закомитить, а используемую команду gcloud добавить в описание репозитория (README.md)

gcloud compute instances create reddit-app-start-script  --boot-disk-size=10GB   --image-family ubuntu-1604-lts   --image-project=ubuntu-os-cloud   --machine-type=g1-small   --tags puma-server   --restart-on-failure --metadata-from-file startup-script="C:\users\nvbul_000\bulnv_infra\startup_script.sh"

>Создайте аналогичное правило из консоли с помощью gcloud. Используемую команду gcloud необходимо добавить в описание репозитория (README.md)

gcloud compute firewall-rules create allow-puma-test --network default --action allow --direction ingress --rules tcp --source-ranges 0.0.0.0/0 --priority 1000 --target-tags puma-server


testapp_IP = 35.204.176.219
testapp_port = 9292 