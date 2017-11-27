#!/bin/bash

clear
echo "------------------------------------------------------------"
echo "---- INICIANDO INSTALACAO DO AMBIENTE DE DESENVOLVIMENTO ---"
echo "------------------------------------------------------------"
echo ""

echo "------------------------------------------------------------------"
echo "--- Adicionando repositorio atual do pacote PHP, APACHE, MYSQL ---"
echo "------------------------------------------------------------------"
sudo apt-get install python-software-properties -y

sudo add-apt-repository ppa:ondrej/php
sudo add-apt-repository ppa:ondrej/apache2
sudo add-apt-repository ppa:ondrej/mysql-5.7
sudo add-apt-repository ppa:nijel/phpmyadmin

echo "------------------------------------"
echo "--- Atualizando lista de pacotes ---"
echo "------------------------------------"
sudo apt-get update && sudo apt-get -y upgrade
echo ""

echo "----------------------------------"
echo "--- Instalando pacotes basicos ---"
echo "----------------------------------"
sudo apt-get --yes --force-yes install vim curl git-core software-properties-common
echo ""

echo "--------------------------------------------------------------"
echo "--- Definindo Senha padrao para o MySQL e suas ferramentas ---"
echo "--------------------------------------------------------------"
DEFAULTPASS="vagrant"
sudo debconf-set-selections <<EOF
mysql-server	mysql-server/root_password password $DEFAULTPASS
mysql-server	mysql-server/root_password_again password $DEFAULTPASS
dbconfig-common	dbconfig-common/mysql/app-pass password $DEFAULTPASS
dbconfig-common	dbconfig-common/mysql/admin-pass password $DEFAULTPASS
dbconfig-common	dbconfig-common/password-confirm password $DEFAULTPASS
dbconfig-common	dbconfig-common/app-password-confirm password $DEFAULTPASS
phpmyadmin		phpmyadmin/reconfigure-webserver multiselect apache2
phpmyadmin		phpmyadmin/dbconfig-install boolean true
phpmyadmin      phpmyadmin/app-password-confirm password $DEFAULTPASS 
phpmyadmin      phpmyadmin/mysql/admin-pass     password $DEFAULTPASS
phpmyadmin      phpmyadmin/password-confirm     password $DEFAULTPASS
phpmyadmin      phpmyadmin/setup-password       password $DEFAULTPASS
phpmyadmin      phpmyadmin/mysql/app-pass       password $DEFAULTPASS
EOF
echo ""

echo "------------------------------------------------------------"
echo "--- Instalando MySQL, Phpmyadmin e alguns outros modulos ---"
echo "------------------------------------------------------------"
sudo apt-get install mysql-server mysql-client phpmyadmin --yes --force-yes

echo "Copiando as configurações do phpmyadmin"
echo "---------------------------------------"
sudo cp -r -f /vagrant/config/etc/phpmyadmin/. /etc/phpmyadmin/.
echo "--- Fim MySQL ---"

echo "--------------------------------------------------------------------------"
echo "--- Instalando PHP 7.1, Suporte Apache, Suporte MySQL e alguns modulos ---"
echo "--------------------------------------------------------------------------"

echo "Instalando PHP 7.1"
echo "------------------"
sudo apt-get install php7.1 php7.1-common --assume-yes --force-yes

echo "Instalando PHP 7.1 Cli"
echo "------------------"
sudo apt-get install php7.1-cli --assume-yes --force-yes


echo "Modulo Apache 2.4"
echo "-----------------"
sudo apt-get install libapache2-mod-php7.1

echo "Modulo MySQL"
echo "------------"
sudo apt-get install --yes --force-yes php7.1-mysql

echo "Modulo SQLite 3"
echo "---------------"
sudo apt-get install --yes --force-yes php7.1-sqlite3

echo "Modulo Curl"
echo "-----------"
sudo apt-get install --yes --force-yes php7.1-curl

echo "Modulo Memcached"
echo "-----------"
sudo apt-get install --yes --force-yes  php-memcached

echo "Modulo PHP 7.1 Dev"
echo "----------"
sudo apt-get install --yes --force-yes php7.1-dev

echo "Modulo Mcrypt"
echo "-------------"
sudo apt-get install --yes --force-yes php7.1-mcrypt

echo "Modulo Mbstring"
echo "-------------"
sudo apt-get install --yes --force-yes php7.1-mbstring

echo "Modulo Zip Unzip"
echo "-------------"
sudo apt-get install --yes --force-yes zip unzip
echo ""

echo "-----------------------------"
echo "--- Habilitando o PHP 7.1 ---"
echo "-----------------------------"
sudo a2dismod php5
sudo a2enmod php7.1
echo ""

echo "--------------------------------------"
echo "--- Baixando e Instalando Composer ---"
echo "--------------------------------------"
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
echo ""

# OBS: SEM SERVIDOR DNS
echo "---------------------------------------------------"
echo "--- Copiando as configuracoes do arquivo hosts  ---"
echo "---------------------------------------------------"
sudo cp -f /vagrant/config/etc/hosts /etc/hosts
echo ""

# OBS: UTLIZANDO SERVIDOR DNS
echo "-----------------------------------"
echo "--- Configurando o resolv.conf  ---"
echo "-----------------------------------"
sudo mv -f /etc/resolv.conf /etc/resolv.conf.old
echo "nameserver 172.0.0.60" >>/etc/resolv.conf
echo ""

echo "-----------------------------------"
echo "--- Reiniciando a Placa de Rede ---"
echo "-----------------------------------"
sudo service networking restart
echo ""

echo "----------------------------------------"
echo "--- Instalando e Configurando Apache ---"
echo "----------------------------------------"
sudo apt-get --yes --force-yes install apache2

# Ativar o modulo rewrite
sudo a2enmod rewrite

# Copiando as configurações do apache
sudo cp -r -f /vagrant/config/etc/apache2/. /etc/apache2/.

# Criando o diretório de projeto.com.br
# sudo mkdir -p /var/www/projeto.com.br/{public_html/,logs/}
# sudo mkdir /var/www/projeto.com.br/

# Para remover diretorio com arquivos dentro utilize 
# rm -rf diretorio

echo "----------------------------"
echo "--- Reiniciando o Apache ---"
echo "----------------------------"
sudo systemctl restart apache2
echo ""

echo "--------------------------------------------------"
echo "[OK] --- AMBIENTE DE DESENVOLVIMENTO CONCLUIDO ---"
echo "--------------------------------------------------"
echo ""

echo "---------------------"
echo "--- Versão do SO  ---"
echo "---------------------"
lsb_release -a
echo ""

echo "------------------------------------"
echo "--- ACESSO SSH EXCUTE O COMANDO  ---"
echo "------------------------------------"
echo "ssh vagrant@192.168.33.10 -p 22"
echo "senha: vagrant"
echo ""