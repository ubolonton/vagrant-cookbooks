require_recipe "git"
require_recipe "python"


%w(libpq-dev).each do |pkg|
    package pkg do
        action :install
    end
end


%w(twisted storm Mako pytz simplejson psycopg2).each do |pkg|
    python_pip pkg do
        action :install
    end
end


bash "install_warp" do
    code <<-EOH
warp_dir=/opt/cogini/lib/
mkdir -p $warp_dir
cd $warp_dir
if git clone https://github.com/brendonh/warp.git
then
    cd warp
    python setup.py install
fi
    EOH
end
