module Hubrel
  class Repo
    # Array of Release with some helpers
    class Releases < Array
      # Get all releases
      def get
        # idempotency
        clear

        # parse REST body and assign items
        require 'json'
        JSON.parse(
          REST.get(path:  "/repos/#{@owner}/#{@name}/releases",
                   token: @token)
        ).each.with_index do |item, index|
          self[index] = Release.new.get(hash: item)
        end

        self
      end

      # Return first release matching the tag name
      def tag(name:)
        select { |release| release[:tag_name] == name }.first
      end

      # Releases are ordered in descending order
      # https://help.github.com/articles/about-releases/
      #
      # Return latest release, be it stable or prerelease
      def latest
        each do |release|
          return release if release.stable || release.prerelease
        end
        nil
      end

      # Return only stable releases
      def stable
        self.class.new(map do |release|
          release if release.stable
        end.compact)
      end
    end
  end
end
