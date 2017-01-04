package 'nginx' do
  action :install
end

# You need Config?
# template "/etc/nginx/conf.d/app.conf" do
#   owner "root"
#   group "root"
#   variables(apps: [])
#   not_if "ls /etc/nginx/conf.d/app.conf.erb"
# end

service 'nginx' do
  action [:enable, :start]
end
