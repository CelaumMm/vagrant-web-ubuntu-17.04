Vagrant.configure("2") do |config|
	config.vm.box = "bento/ubuntu-17.04"
	config.vm.network "forwarded_port", guest: 80, host: 8080

	# Permite o acesso somente da sua maquina para o servidor
	config.vm.network "private_network", ip: "192.168.33.10"
	
	# Permite o acesso do servidor para toda sua rede 
	# OBS: é necessário configurar o IP da sua maquina
	#
	#	-------------------------------------------------------------------
	#	|    ID REDE    |           RANGE IP            |    BROADCAST    |
	#	-------------------------------------------------------------------
	#	|   172.0.0.0   |    172.0.0.1 - 172.0.0.254    |   172.0.0.255   |
	#	-------------------------------------------------------------------
	#	|                     MASCARA: 255.255.255.0                      |
	#	-------------------------------------------------------------------
	#
	#	----------------------------------
	#	|             IP FIXO            |
	#	----------------------------------
	#	|  SERVIDOR WEB   |  172.0.0.50  |
	#	|  SERVIDOR DNS   |  172.0.0.60  |
	#	|-----------------|--------------|
	#	|  SEU PC         |  172.0.0.70  |
	#	----------------------------------
	#
	#config.vm.network "public_network", ip: "172.0.0.50", netmask: "255.255.255.0"
	
	# Compartilhamento da pasta www
	config.vm.synced_folder "www/", "/var/www", owner: "www-data", group: "www-data", mount_options: ['dmode=777','fmode=666']

	config.vm.provider "virtualbox" do |vb|
		# Exibir a GUI do VirtualBox ao inicializar a máquina
		vb.gui = false
		
		#Nome da maquina
		vb.name = "Web Server Ubuntu-17.04"

		# Personalize a quantidade de memória na VM
		vb.memory = "1024"
	end

	
	# Habilitando configurações com um arquivo shell script
	config.vm.provision "shell", path: "setup.sh"
		
	# Habilitando configurações com um shell script inline
	#config.vm.provision "shell", inline: <<-SHELL
	#	apt-get update
	#	apt-get install -y apache2
	#SHELL
end
