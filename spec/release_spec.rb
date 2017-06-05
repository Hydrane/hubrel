require 'json'

# rubocop:disable BlockLength
describe Hubrel::Repo::Release do
  let(:release) { described_class.new }

  describe '.get' do
    it 'returns a filtered hash' do
      expect(
        release.get(
          hash: JSON.parse(File.read("#{File.dirname(__FILE__)}/fixtures/release.json"))
        )
      ).to eq(
        id:         5_467_960,
        prerelease: true,
        draft:      false,
        tag_name:   'v2.3.0-pre9',
        assets:     [
          { id: 3_199_653, name: 'hub-darwin-amd64-2.3.0-pre9.tgz', sum: nil,
            url: 'https://api.github.com/repos/github/hub/releases/assets/3199653' },
          { id: 3_199_654, name: 'hub-freebsd-386-2.3.0-pre9.tgz', sum: nil,
            url: 'https://api.github.com/repos/github/hub/releases/assets/3199654' },
          { id: 3_199_655, name: 'hub-freebsd-amd64-2.3.0-pre9.tgz', sum: nil,
            url: 'https://api.github.com/repos/github/hub/releases/assets/3199655' },
          { id: 3_199_656, name: 'hub-linux-386-2.3.0-pre9.tgz', sum: nil,
            url: 'https://api.github.com/repos/github/hub/releases/assets/3199656' },
          { id: 3_199_657, name: 'hub-linux-amd64-2.3.0-pre9.tgz', sum: nil,
            url: 'https://api.github.com/repos/github/hub/releases/assets/3199657' },
          { id: 3_199_658, name: 'hub-linux-arm-2.3.0-pre9.tgz', sum: nil,
            url: 'https://api.github.com/repos/github/hub/releases/assets/3199658' },
          { id: 3_199_659, name: 'hub-linux-arm64-2.3.0-pre9.tgz', sum: nil,
            url: 'https://api.github.com/repos/github/hub/releases/assets/3199659' },
          { id: 3_199_660, name: 'hub-windows-386-2.3.0-pre9.zip',
            url: 'https://api.github.com/repos/github/hub/releases/assets/3199660',
            sum: '289fb0129f0f19639c33ae4d53508a0f788fd198088601bc1bdd5af9840fb780' },
          { id: 3_199_661, name: 'hub-windows-amd64-2.3.0-pre9.zip',
            url: 'https://api.github.com/repos/github/hub/releases/assets/3199661',
            sum: '333fb0129f0a19s39c33ae4d53508a0f788fd198088601bc1bdd5af9840fb780' },
        ]
      )
    end
  end

  describe '.url' do
    it 'returns an asset url' do
      expect(
        release.get(
          hash: JSON.parse(File.read("#{File.dirname(__FILE__)}/fixtures/release.json"))
        ).asset(name: 'hub-windows-386.*.zip')
      ).to eq(id:   3_199_660,
              name: 'hub-windows-386-2.3.0-pre9.zip',
              sum:  '289fb0129f0f19639c33ae4d53508a0f788fd198088601bc1bdd5af9840fb780',
              url:  'https://api.github.com/repos/github/hub/releases/assets/3199660')
    end
  end
end
