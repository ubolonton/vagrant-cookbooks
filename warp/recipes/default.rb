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
warp_dir=/opt/
mkdir -p $warp_dir
cd $warp_dir
if git clone https://github.com/brendonh/warp.git
then
    cd warp
    # For projects that needs a specific version
    [[ -n $WARP_VERSION ]] && git checkout $WARP_VERSION
    python setup.py install
fi
    EOH

    environment ({
        "WARP_VERSION" => node["warp"]["version"],
    })
end
