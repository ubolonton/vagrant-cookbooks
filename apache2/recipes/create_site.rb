template "/etc/apache2/sites-available/#{node["project"]}" do
    cookbook "vagrant_main"
    source "#{node["project"]}"
end


bash "enable_site" do

    code <<-EOH
a2dissite default
a2ensite $APACHE_SITE
service apache2 restart
    EOH

    environment ({
        "APACHE_SITE" => node["project"],
    })
end
