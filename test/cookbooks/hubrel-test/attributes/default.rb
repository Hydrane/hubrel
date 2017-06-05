release = Hubrel::Repo.new(owner: 'github', name: 'hub').releases.latest
asset   = release.asset(name: 'hub-linux-amd64.+')

default['pkg']['name'] = asset[:name]
default['pkg']['url']  = asset[:url]
default['pkg']['sum']  = asset[:sum]
