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
