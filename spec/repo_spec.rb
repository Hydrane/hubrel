require 'spec_helper'
require 'json'

# rubocop:disable BlockLength
describe Hubrel::Repo do
  let(:repo) { described_class.new(owner: 'foo', name: 'bar') }
  let(:body) { File.read("#{File.dirname(__FILE__)}/fixtures/releases.json") }

  describe '.releases' do
    it 'returns releases' do
      allow(Hubrel::Repo::REST).to receive(:get).and_return(body)
      expect(repo.releases.length).to eq(28)
    end
  end

  describe '.releases.latest' do
    it 'returns the latest release' do
      allow(Hubrel::Repo::REST).to receive(:get).and_return(body)
      expect(repo.releases.latest[:tag_name]).to eq('v2.3.0-pre9')
    end
  end

  describe '.releases.tag' do
    it 'returns a release by tag' do
      allow(Hubrel::Repo::REST).to receive(:get).and_return(body)
      expect(repo.releases.tag(name: 'v2.2.9')[:id]).to eq(4_291_509)
    end
  end

  describe '.releases.stable' do
    it 'returns stable releases' do
      allow(Hubrel::Repo::REST).to receive(:get).and_return(body)
      expect(repo.releases.stable.length).to eq(18)
    end
  end

  describe '.releases.stable.latest' do
    it 'returns the latest stable release' do
      allow(Hubrel::Repo::REST).to receive(:get).and_return(body)
      expect(repo.releases.stable.latest[:tag_name]).to eq('v2.2.9')
    end
  end
end
