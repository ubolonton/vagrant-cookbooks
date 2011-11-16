require_recipe "php"

bash "install_codeigniter" do

    code <<-EOH
if [ ! -d /opt/codeigniter ]
then
    cd /opt
    CIFILE="CodeIgniter_1.7.3"
    ZIPFILE="$CIFILE.zip"
    wget http://downloads.codeigniter.com/$ZIPFILE
    unzip $ZIPFILE
    ln -s $CIFILE codeigniter
    rm $ZIPFILE
fi
    EOH
end
