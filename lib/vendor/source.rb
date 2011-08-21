# Represents a source from which fetch and load libraries

module Vendor
  class Source
    attr_reader :path

    # Vendor::Source.new("https://github.com/bazaarlabs/vendor")
    # Vendor::Source.new("./formulae")
    def initialize(path)
      @path = path
    end

    # Returns enhanced string representation
    # @source.to_s = "<Source> @path="http://path/to/remote/source/repo.git""
    def to_s
      "#{super} @path=#{self.path}"
    end # to_s

    # Fetch source and require files locally
    # @source.fetch
    def fetch
      if @path =~ /.git$/
        puts "[source] fetching source path from #{self.path}"
        # TODO actually fetch source and load formula
      end
    end # fetch
  end
end