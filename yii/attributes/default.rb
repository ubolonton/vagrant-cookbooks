default["yii"]["version"] = "1.1.8.r3324"
default["yii"]["base_dir"] = "/vagrant/#{node["project"]}"
default["yii"]["symlink"] = "#{node["yii"]["base_dir"]}/../yii"
default["yii"]["config_dir"] = "#{node["yii"]["base_dir"]}/protected/config"
