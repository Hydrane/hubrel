module Hubrel
  class Repo
    # Filtered out Hash with extracted checksums
    class Release < Hash
      # Filter out, sanitize, and return a release object from
      # a hash created by the JSON parser parsing the REST response
      def get(hash:)
        # idempotency
        clear

        # get checksums from the release description
        sums = checksums(text: hash['body'])

        # copy over fields
        %i[id prerelease draft tag_name].each { |i| self[i] = hash[i.to_s] }

        # join checksums extracted from the body to filtered asset fields
        self[:assets] = hash['assets'].map do |asset|
          { id:   asset['id'],   url: asset['url'],
            name: asset['name'], sum: sums.fetch(asset['name'], nil) }
        end

        # return clean hash
        self
      end

      # return the download url of an asset in a release by name
      def url(asset:)
        self[:assets].select { |item| item[:name] =~ /#{asset}/ }.first.fetch(:url, nil)
      end

      # release is stable if it is not a draft and not a prerelase
      def stable
        self[:draft] == false && self[:prerelease] == false
      end

      # release is prerelease if it is a prerelase and not a draft
      def prerelease
        self[:draft] == false && self[:prerelease] == true
      end

      private

      # This method takes something like:
      # ```checksums
      # 123checksum321 name.txt
      # 111checksum333 name2.txt
      # ```
      # and outputs:
      # { "name.txt" => "123checksum321",
      # { "name2.txt" => "111checksum333" }
      #
      # It tries to sanitize the input as much as possible.
      # If multiple names are defined with different sums,
      # only the last one is taken into account.
      #
      def checksums(text:)
        # extract everything in the "checksum" block and return lines
        lines = text.scan(/```checksums?(.+?)```/m).flatten.map do |match|
          # remove all newline characters, incorrect whitespace, nils, and empty strings
          match.lines.map { |line| line.strip.gsub(/\s+/, ' ') }.compact.reject(&:empty?)
        end.flatten

        # separate lines into hashes
        Hash[lines.map { |line| line.split(' ', 2).reverse }]
      end
    end
  end
end
