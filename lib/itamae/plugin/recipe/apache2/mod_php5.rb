service 'apache2' do
  action :nothing
end

execute 'a2enmod php5' do
  command 'a2enmod php5'
  notifies :restart, 'service[apache2]'
end
