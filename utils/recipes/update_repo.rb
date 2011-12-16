bash "update_repo" do
    code <<-EOH
apt-get update -o Acquire::http::No-Cache=True
exit 0 # This is optional, always succeed
    EOH
end
