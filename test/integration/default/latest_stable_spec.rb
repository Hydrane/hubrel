describe 'package' do
  it 'is downloaded from the /releases/latest endpoint' do
    expect(command(
      'curl -o inspec.tgz -LO $(curl -s '\
      'https://api.github.com/repos/github/hub/releases/latest ' \
      '| grep -o "http.*linux-amd64.*tgz")'
    ).exit_status).to eq(0)
  end

  it 'is matching the one downloaded by Chef' do
    expect(command('diff -s *.tgz').stdout).to include('are identical')
    expect(command('diff -s *.tgz').exit_status).to eq(0)
  end
end
