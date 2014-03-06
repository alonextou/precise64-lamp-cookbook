#
# Cookbook Name:: precise64-lamp
# Recipe:: default
#
# Copyright (C) 2014 Alex Crawford
# 
# All rights reserved - Do Not Redistribute
#

# ----------------------------------- #
# => Sites                            #
# ----------------------------------- #

web_app "web.dev" do
  server_name "web.dev"
  docroot "#{node['precise64-lamp']['webroot']}"
end

web_app "joomla.dev1.cagehost.com" do
  server_name "joomla.dev1.cagehost.com"
  docroot "#{node['precise64-lamp']['webroot']}/joomla"
end

# ----------------------------------- #
# => Databases                         #
# ----------------------------------- #

mysql_database 'joomla' do
  connection ({
    :host => "127.0.0.1",
    :username => 'root',
    :password => node['mysql']['server_root_password']
  })
  action :create
end