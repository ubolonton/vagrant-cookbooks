description "Start the twistd process that serves warp webapps"
author "Hoang Xuan Phu <phu@cogini.com>"

start on runlevel [2345]
stop on runlevel [06]

exec twistd \
    -u`id -u <%= @user %>` \
    -g`id -g <%= @group %>` \
    --pidfile=<%= @pid_file %> \
    --logfile=<%= @log_file %> \
    -n warp \
    --siteDir=<%= @site_dir %>

respawn
