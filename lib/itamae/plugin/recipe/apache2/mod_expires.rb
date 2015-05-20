service 'apache2' do
  action :nothing
end

execute 'a2enmod expires' do
  command 'a2enmod expires'
  notifies :restart, 'service[apache2]'
end
