# install packages
%w(php70 php70-mbstring php7-pear php70-fpm php70-mcrypt php70-mysqlnd php70-opcache php70-pecl-apcu).each do |pkg|
  package pkg
end

service "php-fpm" do
  action [:enable, :start]
end

execute 'sed -i "s/user = apache/user = nginx/" /etc/php-fpm.d/www.conf && sed -i "s/group = apache/group = nginx/" /etc/php-fpm.d/www.conf' do
  notifies :reload, "service[php-fpm]"
  not_if "grep 'user = nginx' /etc/php-fpm.d/www.conf"
end
