bash "restart_psql" do

    code <<-EOH
service postgresql-8.4 restart
chmod +rx /vagrant
chmod +r /vagrant/dump.sql
    EOH
end

bash "restore_psql" do

    user "postgres"

    code <<-EOH
dropuser $USER && echo "User $USER dropped"
dropdb $DATABASE && echo "Database $DATABASE dropped"
createuser --no-superuser --no-createdb --no-createrole $USER
createdb --locale POSIX --encoding UTF8 --template template0 --owner $USER $DATABASE
psql -U$USER $DATABASE < /vagrant/dump.sql
    EOH

    environment ({
        "USER" => node["psql"]["user"],
        "DATABASE" => node["psql"]["database"],
    })
end
