require_recipe "git"
require_recipe "php"

bash "install_yii" do

    code <<-EOH
if [ ! -d /opt/yii/.git ]
then
    rm -rf /opt/yii*
fi

cd /opt
git clone https://github.com/yiisoft/yii.git
cd yii
git fetch
git checkout $YII_VERSION

ln -s /opt/yii /vagrant
mkdir -p /vagrant/$PROJECT_NAME/assets
mkdir -p /vagrant/$PROJECT_NAME/protected/runtime
    EOH

    environment ({
        "YII_VERSION" => node["yii"]["version"],
        "PROJECT_NAME" => node["project"],
    })
end


config_dir = node["yii"]["config_dir"]

%w(main db console modules).each do |config_file|
    dest_file = "#{config_dir}/#{config_file}.php"
    template dest_file do
        cookbook "vagrant_main"
        source "#{config_file}.php"
        not_if do
            File.exists?(dest_file)
        end
    end
end
