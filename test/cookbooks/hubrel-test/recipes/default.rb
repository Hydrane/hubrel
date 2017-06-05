remote_file 'asset' do
  path     node['pkg']['name']
  source   node['pkg']['url']
  checksum node['pkg']['sum']
  headers('Accept' => 'application/octet-stream')
end
