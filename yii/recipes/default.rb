require_recipe "php"


bash "install_yii" do

    code <<-EOH
if [ ! -h /opt/yii ]
then
    YII_FILE="yii-$YII_VERSION.tar.gz"
    cd /opt
    wget http://yii.googlecode.com/files/$YII_FILE
    tar -xvf $YII_FILE
    ln -s "yii-$YII_VERSION" yii
    rm $YII_FILE
fi

ln -s /opt/yii /vagrant/yii
mkdir -p /vagrant/$PROJECT_NAME/assets
mkdir -p /vagrant/$PROJECT_NAME/protected/runtime
    EOH

    environment ({
        "YII_VERSION" => node["yii"]["version"],
        "PROJECT_NAME" => node["project"]["name"],
    })
end
