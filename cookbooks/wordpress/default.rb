require 'open-uri'

node["multi_wordpress"].each do |app|

  # download wordpress
  execute "download and extract wordpress" do
    commands = [
      "cd /tmp",
      "wget \"https://ja.wordpress.org/latest-ja.zip\"",
      "unzip latest-ja.zip",
      "mv wordpress #{app['root']}",
      "rm -rf latest-ja.zip",
      "chown -R nginx:nginx #{app['root']}"
    ]

    command commands.join(" && ")
    not_if "test -d #{app['root']}"
  end

  # setup database
  execute "mysql -uroot -e \"CREATE DATABASE IF NOT EXISTS #{app['db_name']} character set utf8\""
execute "mysql -uroot -e \"GRANT ALL ON \\`#{app['db_name']}\\`.* to '#{app['db_user']}'@'localhost' identified by '#{app['db_password']}'\""

  # create wp-config.php
  ## obtain keys
  keys = []
  open ("https://api.wordpress.org/secret-key/1.1/salt/") {|io|
    keys << io.read
  }

  ## generate wp-config from template
  template "#{app['root']}/wp-config.php" do
    source "./templates/wordpress/wp-config.php.erb"
    variables ({
      db_name: app['db_name'],
      db_user: app['db_user'],
      db_password: app['db_password'],
      secret_keys: keys.join("\n")
    })
    mode "644"
    owner "root"
    group "root"

    not_if "test -e #{app['root']}/wp-config.php"
  end
end

template "/etc/nginx/conf.d/wordpress.conf" do
  mode "644"
  owner "root"
  group "root"
  variables(apps: node["multi_wordpress"])
  notifies :reload, "service[nginx]"
end
