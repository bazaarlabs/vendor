module Vendor
  class Source
    attr_reader :path

    # Vendor::Source.new("https://github.com/bazaarlabs/vendor")
    # Vendor::Source.new("./formulae")
    def initialize(path)
      @path = path
    end

    def to_s
      "#{super} @path=#{self.path}"
    end # to_s

    def fetch
      if @path =~ /.git$/
        puts "[source] fetching source path from #{self.path}"
        # TODO actually fetch source and load formula
      end
    end # fetch
  end
end