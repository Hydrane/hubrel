remote_file 'hub.tgz' do
  headers('Accept' => 'application/octet-stream')
  source node['pkg_url']
end
