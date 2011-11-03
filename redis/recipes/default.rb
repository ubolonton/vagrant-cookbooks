%w(checkinstall tcl8.5).each do |pkg|
    package pkg do
        action :install
    end
end


bash "setup_redis" do
    code <<-EOH
cd /opt
wget http://redis.googlecode.com/files/redis-2.4.2.tar.gz
tar -xvf redis-2.4.2.tar.gz
cd redis-2.4.2
make
checkinstall -y
cd utils
echo '' | ./install_server.sh
    EOH
end
