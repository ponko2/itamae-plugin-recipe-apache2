package 'apache2'

service 'apache2' do
  action [:start, :enable]
end

execute 'a2dissite 000-default' do
  command 'a2dissite 000-default'
  only_if 'test -L /etc/apache2/sites-enabled/000-default.conf'
  notifies :reload, 'service[apache2]'
end
