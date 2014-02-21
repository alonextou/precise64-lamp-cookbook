#
# Cookbook Name:: precise64-lamp
# Recipe:: default
#
# Copyright (C) 2014 Alex Crawford
# 
# All rights reserved - Do Not Redistribute
#

# ----------------------------------- #
# => Packages                         #
# ----------------------------------- #

package "php5-mysql" do
  action :install
end

package "php5-curl" do
  action :install
end

package "php5-mcrypt" do
  action :install
end

# ----------------------------------- #
# => Apache                           #
# ----------------------------------- #

include_recipe "apache2"

web_app "web.dev" do
  server_name "web.dev"
  docroot "/var/www"
end

# ----------------------------------- #
# => PHP                              #
# ----------------------------------- #

directory "/etc/php5/apache2" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end

template "/etc/php5/apache2/php.ini" do
  source "php.ini.erb"
  owner "root"
  group "root"
  mode "0644"
end

# ----------------------------------- #
# => Scripts                          #
# ----------------------------------- #

template "/usr/local/bin/chweb" do
  source "chweb.erb"
  owner "root"
  group "staff"
  mode "0755"
end
