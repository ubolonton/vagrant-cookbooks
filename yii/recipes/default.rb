require_recipe "php"

bash "install_yii" do
    code <<-EOH

if [ ! -d /opt/yii ]
then
    YII_VERSION="1.1.8.r3324"
    YII_FILE="yii-$YII_VERSION.tar.gz"
    cd /opt
    wget http://yii.googlecode.com/files/$YII_FILE
    tar -xvf $YII_FILE
    ln -s "yii-$YII_VERSION" yii
    rm $YII_FILE
fi

    EOH
end
