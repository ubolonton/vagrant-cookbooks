bash "restore_mysql" do

    code <<-EOH
mysql --user=root --password=vagrant <<EOSQL
    grant usage on *.* to $USER;
    drop user $USER;
    drop database if exists $DATABASE;
    create user $USER identified by '$PASSWORD';
    create database $DATABASE;
    grant all on $DATABASE.* to $USER;
EOSQL
mysql --user=$USER --password=$PASSWORD $DATABASE < /vagrant/dump.sql
    EOH

    environment ({
        "USER" => node["mysql"]["user"],
        "DATABASE" => node["mysql"]["database"],
        "PASSWORD" => node["mysql"]["password"],
    })
end
