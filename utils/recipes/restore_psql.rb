bash "restore_psql" do

    user "postgres"

    code <<-EOH
dropuser $USER
dropdb $DATABASE
createuser --no-superuser --no-createdb --no-createrole $USER
createdb $DATABASE -l POSIX -E UTF8 -T template0
psql $DATABASE < /vagrant/dump.sql
    EOH

    environment ({
        "USER" => node["psql"]["user"],
        "DATABASE" => node["psql"]["database"],
        "PASSWORD" => node["psql"]["password"],
    })
end
