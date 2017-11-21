Vagrant-Setup
===========

Servidor LAMP (Linux, Apache, MySQL, PHP)

Configuração do Vagrant (com provisionamento em Shell Script) para criar uma máquina virtual (Ubuntu Server 17.04 64 Bits) de desenvolvimento em PHP.

### Pacotes Inclusos:

- PHP 7.1
- MySQL 5.7
- Git
- PhpMyAdmin 
- Composer
- cURL
- Vim

(Para mais detalhes consulte arquivo setup.sh)


Você vai precisar: 
==============

- Virtualbox - https://www.virtualbox.org/
- Vagrant - http://www.vagrantup.com/
- Git - http://git-scm.com
- Acesso Internet


-> Instale o Virtualbox e o Vagrant de acordo com seu sistema operacional. ( A instalação é bem simples e pode ser feita sem muitas dificuldades... )


Modo de Uso
===========

A instalação inicial pode ser feita de duas formas, sendo:

1º) Caso tenha o Git instaldo em sua máquina, proceda da seguinte forma:



* Clone esse repositório para sua máquina:

- git clone https://github.com/CelaumMm/vagrant-web-ubuntu-17.04 ( Execute o comando no seu Prompt/Terminal )

* Ainda no Prompt de comando/Terminal Entre no diretório vagrant-setup-php  ( Ou o que você definir na hora da clonagem )

* Inicie a máquina virtual com o comando:

- vagrant up 




2º) Caso não tenha o Git instalado em sua máquina, acesse https://github.com/CelaumMm/vagrant-web-ubuntu-17.04 baixe o arquivo do projeto no formato .zip e descompacte-o onde desejar.

* Abra seu Prompt/Terminal , acesse o diretorio que acabou de descompactar e rode o comando:

- vagrant up




Após este comando 'vagrant up', o Vagrant ficará responsavel por baixar o sistema operacional ( neste caso Ubuntu Server 64 ), configurar a máquina virtual no VirtualBox e posteriormente baixar, instalar e configurar todos os pacotes do script 'setup.sh' (Sim! A primeira vez realmente é um pouco mais demorado).

Quando tudo estiver pronto, um servidor web estará disponível no endereço http://localhost:8080, e a instalação do PHPMyAdmin está em http://localhost:8080/phpmyadmin, para acessar utilize:

- Login: root
- Senha: vagrant

obs:(A senha padrão para todos os serviços é vagrant).


Coloque seu código no diretório "www". Todo o conteúdo dele estará disponível via http://localhost:8080

Para desligar a máquina virtual utilize o comando:

- vagrant halt

Para religar novamente utilize:

- vagrant up

Caso queira destruir a máquina virtual (o conteúdo do www não será excluido):

- vagrant destroy


3º) (Opicional) Editar o arquivo hots do seu windows no caminho C:\Windows\System32\drivers\etc\hosts

Adicionar as linhas abaixo 

- 192.168.33.10 phpmyadmin.dev
- 192.168.33.10 local.dev
- 192.168.33.10 projeto.com.br
- 192.168.33.10 www.projeto.com.br

4°) (Opicional) Acessar no navegador da sua maquina

- http://phpmyadmin.dev

- http://local.dev

- http://projeto.com.br

5°) (Opicional) Acessar seu servidor via SSH, abra o Git Bash

- ssh vagrant@192.168.33.10 -p 22
- senha: vagrant
