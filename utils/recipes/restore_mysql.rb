bash "restore_mysql" do

    code <<-EOH
mysql --user=root --password=vagrant <<EOSQL
    grant usage on *.* to $USER;
    drop user $USER;
    drop database if exists $DB_NAME;
    create user $USER identified by '$PASSWORD';
    create database $DB_NAME;
    grant all on $DB_NAME.* to $USER;
EOSQL
mysql --user=$USER --password=$PASSWORD $DB_NAME < /vagrant/dump.sql
    EOH

    environment ({
        "USER" => node["mysql"]["user"],
        "DB_NAME" => node["mysql"]["db_name"],
        "PASSWORD" => node["mysql"]["password"],
    })
end
