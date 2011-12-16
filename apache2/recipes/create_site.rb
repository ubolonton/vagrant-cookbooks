template "/etc/apache2/sites-available/#{node["project"]}" do
    source "#{node["project"]}"
end

bash "enable_site" do
    code <<-EOH
a2dissite default
a2ensite #{project_name}
service apache2 restart
    EOH
end
