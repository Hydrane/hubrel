module Hubrel
  # Code to get necessary info from a GitHub repository
  class Repo
    require_relative 'hubrel_repo_releases'
    require_relative 'hubrel_repo_release'

    def initialize(owner:, name:, token: nil)
      @owner  = owner
      @name   = name
      @token  = token
    end

    # return last header used
    attr_reader :header

    def releases
      require 'json'
      @header = @token ? { 'Authorization' => "token #{@token}" } : {}
      parsed  = JSON.parse(REST.get(path: "/repos/#{@owner}/#{@name}/releases", header: @header))
      @releases ||= Releases.new.get(array: parsed)
    end

    # wrappers around Net::HTTP and the GitHub REST API
    # NOTE: at the time of writing, the GraphQL API (v4) did not have
    #       fields for prereleases or support for release creation
    module REST
      require 'net/http'

      # TODO: paging suport
      def self.get(url: nil, path:, header: {})
        uri = URI.join(url ? url : 'https://api.github.com', path)
        req = Net::HTTP::Get.new(uri)
        # build header
        header.each { |key, value| req[key] = value }
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(req)
        end
        # TODO: error handling
        res.body
      end
    end
  end
end
