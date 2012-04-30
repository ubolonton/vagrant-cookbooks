require_recipe "mercurial"
require_recipe "python"

%w(urwid).each do |pkg|
    python_pip pkg do
        action :install
    end
end

bash "install_bpython" do

    code <<-EOH
opt=/opt/
mkdir -p $opt
cd $opt
if hg clone https://bitbucket.org/bobf/bpython
then
    cd bpython
    [[ -n $BPYTHON_VERSION ]] && hg update -C $BPYTHON_VERSION
    python setup.py install
fi
  EOH

    environment ({
        "BPYTHON_VERSION" => node["bpython"]["version"],
    })
end
