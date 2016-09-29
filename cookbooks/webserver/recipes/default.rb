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
execute "gem install rspec" do
  command "gem install rspec"
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
