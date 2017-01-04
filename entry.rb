require 'itamae'
node['roles'] = node['roles'] || []
node['roles'].each do |role|
  include_recipe "roles/#{role}.rb"
end
