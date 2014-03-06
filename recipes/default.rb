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

sites = []
sites = data_bag("sites")
sites.each do |name|
  site = data_bag_item("sites", name)

  web_app "#{site['name']}.#{node['precise64-lamp']['hostname']}" do
    server_name "#{site['name']}.#{node['precise64-lamp']['hostname']}"
    docroot "#{node['precise64-lamp']['webroot']}/#{site['path']}"
  end

   bash "hosts" do
     code "echo 127.0.0.1 #{site['name']}.#{node['precise64-lamp']['hostname']} >> /etc/hosts"
   end
end

# ----------------------------------- #
# => MySQL                            #
# ----------------------------------- #

include_recipe "mysql::server"
include_recipe "database::mysql"

=begin
include_recipe "mysql::server"
include_recipe "database::mysql"

service "mysql" do
  action :enable
end

databases = []
databases = data_bag("databases")
databases.each do |name|
  database = data_bag_item("databases", name)

  mysql_database "#{database['name']}" do
    connection ({
      :host => "127.0.0.1",
      :username => "root",
      :password => node['mysql']['server_root_password']
    })
    action :create
  end
end
=end

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
