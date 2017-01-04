%w(mysql56 mysql56-server).each do |pkg|
  package pkg
end

service 'mysqld' do
  action [:enable, :start]
end
