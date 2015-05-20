service 'apache2' do
  action :nothing
end

execute 'a2enmod rewrite' do
  command 'a2enmod rewrite'
  notifies :restart, 'service[apache2]'
end
