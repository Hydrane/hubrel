repo = Hubrel::Repo.new(owner: 'github', name: 'hub')

default['pkg_url'] = repo.releases.stable.latest.url(asset: 'hub-linux-amd64.+')
