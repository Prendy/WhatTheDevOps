#
# Cookbook Name:: webserver
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

apt_update 'Update the apt cache daily' do
  frequency 86_400
  action :periodic
end
package 'git'
package 'nginx'
package 'nodejs'
package 'build-essential'
package 'npm'
package 'nodejs-legacy'
package 'ruby-full'
execute "gem install rspec" do
  command "gem install rspec"
end
execute "gem install selenium" do
  command "gem install selenium-webdriver"
end

execute "clean up dependencies" do
    command "apt-get -f install -y"
end

execute "install some dependencies" do
  command "sudo apt-get install libxss1 libappindicator1 libindicator7 -y"
end

execute "download chrome" do
  command "wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
end

execute "install chrome" do
  command "sudo dpkg -i google-chrome*.deb"
end



execute "instal xvfb" do
  command "sudo apt-get install xvfb -y"
end

execute "install chromedriver" do
  command "sudo apt-get install unzip"
  command "wget -N http://chromedriver.storage.googleapis.com/2.20/chromedriver_linux64.zip"
  command "unzip chromedriver_linux64.zip"
  command "chmod +x chromedriver"
  command "sudo mv -f chromedriver /usr/local/share/chromedriver"
  command "sudo ln -s /usr/local/share/chromedriver /usr/local/bin/chromedriver"
  command "sudo ln -s /usr/local/share/chromedriver /usr/bin/chromedriver"
end

service 'nginx' do
  action [ :enable, :start ]
end

template '/etc/nginx/sites-enabled/default' do
 source 'default.erb'
end

file '/var/www/html/index.nginx-debian.html' do
  action :delete
  only_if { File.exist? '/var/www/html/index.nginx-debian.html' }
end

execute "change permissions on html" do
  command "sudo chown -R www-data:www-data /var/www/*"
  command "sudo chmod -R 0755 /var/www/*"
end

execute "sudo npm install pm2 -g" do
  command "sudo npm install pm2 -g"
end

service 'nginx' do
  action [ :restart ]
end
