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
        "USER" => node["mysql"]["user"],
        "DATABASE" => node["mysql"]["database"],
        "PASSWORD" => node["mysql"]["password"],
    })
end
