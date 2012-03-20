require_recipe "git"


%w(unixodbc-dev checkinstall).each do |pkg|
    package pkg do
        action :install
    end
end


bash "install_from_git" do

    code <<-EOH

apt-get build-dep erlang
source_dir=/opt/erlang

# In case something is there
if [ ! -d $source_dir/.git ]
then
    rm -rf $source_dir
fi

git clone https://github.com/erlang/otp.git $source_dir
cd $source_dir
git fetch
git checkout $VERSION

./otp_build autoconf
./configure
./make
# Need a package version, otherwise checkinstall can't make a deb
checkinstall --pkgversion=1 -y

    EOH

    environment ({
        "VERSION" => node["erlang"]["version"],
    })
end
