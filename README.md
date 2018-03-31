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

gcloud compute firewall-rules create allow-puma-test --network default --action allow --direction ingress --rules tcp:80 --source-ranges 0.0.0.0/0 --priority 1000 --target-tags puma-server

testapp_IP=35.204.176.219
testapp_port=9292

# Homework-6
 - При помощи packer "запечен" образ Ununtu с предустановленным MongoDB, Ruby и пост фактум задеполеным приложением reddit (Параметрирование выполнено через переменныи и подключаемый файл json)
 - В рамках задания со * с помощью packer подготовлен fully-baked образ с предустановленным приложением и автоматически запускающимся веб сервером puma в качестве systemd unit'a
 - В папке config-scripts софрмирован скрипт позволяющий запустить итоговый инстанс.

 # Homework-7
 - Определены переменные
 - Отформатированы конфиги с использованием terraform fmt
 - Добавлен terraform.tfvars.example

 ## Задание со *
 [x] Опишите в коде терраформа добавление ssh ключа пользователя appuser1 в метаданные проекта.
Выполните terraform apply и проверьте результат (публичный ключ можно брать пользователя
appuser);
 [x] Опишите в коде терраформа добавление ssh ключей нескольких пользователей в метаданные
проекта (можно просто один и тот же публичный ключ, но с разными именами пользователей,
например appuser1, appuser2 и т.д.). Выполните terraform apply и проверьте результат;
**Вот тут возникла сложность - ключи не заливались с ошибкой что ключи в проекте уже есть**
 [x] Добавьте в веб интерфейсе ssh ключ пользователю appuser_web в метаданные проекта. Выполните
terraform apply и проверьте результат;
**а после этой команды ключи добавленные в ручную - удалились**
 [x] Обнаруженные проблемы: Помимо изложенных выше - terraform apply периодически валится с ошибкой `google_compute_instance.app: ssh: handshake failed: ssh: unable to authenticate, attempted methods [none publickey], no supported methods remain` отписал проблему в чате

 ## Задание с **
 [x] Создайте файл lb.tf и опишите в нем в коде terraform создание HTTP балансировщика, направляющего
трафик на наше развернутое приложение на инстансе reddit-app...  выполнено
 [x] Добавьте в код еще один инстанс приложения, например reddit-app2, добавьте его в балансировщик и
проверьте... выполнено
 [x] ... и попробуйте подход с заданием колличества инстансов через....
 не знаю что имелось ввиду, но я сделал через auto_scaler правильно ли это?

 
