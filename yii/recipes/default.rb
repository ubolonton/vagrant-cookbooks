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

rm -rf $YII_SYMLINK
ln -s /opt/yii $YII_SYMLINK
mkdir -p $YII_BASE/assets
mkdir -p $YII_BASE/protected/runtime
    EOH

    environment ({
        "YII_VERSION" => node["yii"]["version"],
        "YII_BASE" => node["yii"]["base_dir"],
        "YII_SYMLINK" => node["yii"]["symlink"],
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
