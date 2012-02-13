bash "restore_psql" do

    user "postgres"

    code <<-EOH
dropuser $USER 2> /dev/null
dropdb $DATABASE 2> /dev/null
createuser --no-superuser --no-createdb --no-createrole $USER
createdb --locale POSIX --encoding UTF8 --template template0 --owner $USER $DATABASE
psql -U$USER $DATABASE < /vagrant/dump.sql
    EOH

    environment ({
        "USER" => node["psql"]["user"],
        "DATABASE" => node["psql"]["database"],
    })
end
