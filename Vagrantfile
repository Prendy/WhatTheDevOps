Vagrant.configure("2") do |config|
  #config.vm.box = "bento/ubuntu-16.04"
  #config.vm.provision "shell", path: "webserver/provision.sh"
  #config.vm.network :forwarded_port, guest: 80, host: 3000
  #config.vm.synced_folder "webserver/", "/root/servers/webserver"
  #config.vm.synced_folder "../app", "/var/www/html"
  #config.vm.provision "shell", inline: "cd /var/www/html"
  #config.vm.provision "shell", inline: "sudo usermod -a -G www-data vagrant"
  #config.vm.provision "shell", inline: "sudo chown -R vagrant:www-data /var/www"
  #######ß
  config.vm.define "test" do |test|
    test.vm.box = "bento/ubuntu-16.04"
    test.vm.synced_folder "cookbooks/", "/home/vagrant/cookbooks"
  end

  config.vm.define "app" do |app|
    app.vm.box = "bento/ubuntu-16.04"
    #app.vm.provision "shell", path: "webserver/provision.sh"
    app.vm.network :forwarded_port, guest: 80, host: 3000
    app.vm.network "private_network", ip: "192.10.10.100"
    app.vm.synced_folder "webserver/", "/root/servers/webserver"
    app.vm.synced_folder "../app", "/var/www/html"
    #app.vm.synced_folder "../api", "/var/www/html/api"
    app.vm.synced_folder "cookbooks/", "/home/vagrant/cookbooks"
    app.vm.provision "shell", inline: "sudo usermod -a -G www-data vagrant"
    app.vm.provision "shell", inline: "sudo chown -R vagrant:www-data /var/www"
    app.vm.provision "shell", inline: "sudo apt-get install curl"
    app.vm.provision "shell", inline: "curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.16.28"
    app.vm.provision "shell", inline: "sudo chef-client --local-mode --runlist 'recipe[webserver]'"
  end

  config.vm.define "api" do |api|
    api.vm.box = "bento/ubuntu-16.04"
    #api.vm.provision "shell", path: "webserver/provision_api.sh"
    api.vm.network :forwarded_port, guest: 80, host: 3001
    api.vm.network "private_network", ip: "192.10.10.150"
    api.vm.synced_folder "webserver/", "/root/servers/webserver"
    api.vm.synced_folder "../api", "/var/www/html"
    api.vm.synced_folder "cookbooks/", "/home/vagrant/cookbooks"
    api.vm.provision "shell", inline: "sudo usermod -a -G www-data vagrant"
    api.vm.provision "shell", inline: "sudo chown -R vagrant:www-data /var/www"
    api.vm.provision "shell", inline: "sudo apt-get install curl"
    api.vm.provision "shell", inline: "curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.16.28"
    api.vm.provision "shell", inline: "sudo chef-client --local-mode --runlist 'recipe[webserver::api]'"
  end

  config.vm.define "db" do |db|
    db.vm.box = "bento/ubuntu-16.04"
    #db.vm.provision "shell", path: "database/provision.sh"
    #db.vm.network :forwarded_port, guest: 80, host: 27017
    db.vm.network "private_network", ip: "192.10.10.200"
    db.vm.synced_folder "database/", "/root/servers/database"
    db.vm.synced_folder "cookbooks/", "/home/vagrant/cookbooks"
    #db.vm.provision "shell", inline: "sudo usermod -a -G www-data vagrant"
    #db.vm.provision "shell", inline: "sudo chown -R vagrant:www-data /var/www"
    db.vm.provision "shell", inline: "sudo apt-get install curl"
    db.vm.provision "shell", inline: "curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P chefdk -c stable -v 0.16.28"
    db.vm.provision "shell", inline: "sudo chef-client --local-mode --runlist 'recipe[db]'"
  end
end
