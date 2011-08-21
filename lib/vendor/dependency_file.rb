# Represents the dependency "Vendors" file declaring required libraries

module Vendor
  class DependencyFile
    include Vendor::Helpers

    attr_reader :sources

    # Vendor::DependencyFile.new("path/to/project/Vendors")
    def initialize(file_path)
      @file_path = file_path
      @text = File.read(file_path)
      @sources, @libs = [], []
      self.instance_eval(@text)
    end

    # source "https://github.com/bazaarlabs/vendor"
    def source(path=nil)
      @sources << Vendor::Source.new(path) if path
    end

    # lib "three20", :class => 'Three20'
    # lib "asi-http-request", :git => "https://github.com/pokeb/asi-http-request.git"
    # lib "asi-http-request", :git => "https://github.com/pokeb/asi-http-request.git", :branch => "foobar"
    def lib(name, options={})
      @libs << options.merge(:name => name)
    end

    # Returns library instances based on specified Vendors information
    # @depfile.libraries => [<Library>, <Library>]
    def libraries
      @_libraries ||= @libs.map do |lib_data|
        resolve_library(lib_data)
      end
    end # libraries
  end # DependencyFile
end # Vendor