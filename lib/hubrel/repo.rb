module Hubrel
  # Code to get necessary info from a GitHub repository
  class Repo
    require 'hubrel/repo/releases'
    require 'hubrel/repo/release'

    def initialize(owner:, name:, token: nil)
      @owner = owner
      @name  = name
      @token = token
    end

    def releases
      @releases ||= Releases.new.get
    end

    # wrappers around Net::HTTP and the GitHub REST API
    # NOTE: at the time of writing, the GraphQL API (v4) did not have
    #       fields for prereleases or support for release creation
    module REST
      require 'net/http'

      # TODO: paging suport
      def self.get(url: nil, path:, token: nil)
        uri = URI.join(url ? url : 'https://api.github.com', path)
        req = Net::HTTP::Get.new(uri)
        req['Authorization'] = "token #{token}" if token
        res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == 'https') do |http|
          http.request(req)
        end
        # TODO: error handling
        res.body
      end
    end
  end
end
