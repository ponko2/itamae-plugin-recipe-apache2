node.validate! do
  {
    apache2: {
      listen_ports: optional(array_of(integer)),
      sites: array_of({
        name: string,
        server_name: string,
        server_port: optional(integer),
        server_aliases: optional(array_of(string)),
        docroot: string,
        directory_options: optional(array_of(string)),
        directory_index: optional(array_of(string))
      })
    }
  }
end

node.reverse_merge!(
  apache2: {
    listen_ports: [80]
  }
)

service 'apache2' do
  action :nothing
end

node[:apache2][:sites].each do |site|
  template "/etc/apache2/sites-available/#{site[:name]}.conf" do
    source 'templates/etc/apache2/sites-available/site.conf.erb'
    variables(params: site)
    owner 'root'
    group 'root'
    mode '0644'
  end

  execute "a2ensite #{site[:name]}" do
    command "a2ensite #{site[:name]}"
    notifies :reload, 'service[apache2]'
  end
end
