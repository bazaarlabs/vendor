# Represents a Vendor.lock file detailing the locked libraries and versions

module Vendor
  class LockFile
    include Vendor::Helpers

    # Construct a lockfile representation
    # Vendor::LockFile.new("/path/to/project/Vendor.lock", <DependencyFile>, ...)
    def initialize(lock_path, depfile, options={})
      @path = lock_path
      @depfile = depfile
    end

    # Returns libraries specified in Vendor.lock
    # @lockfile.libraries => [<Library>, <Library>]
    def libraries
      File.read(@path).split("\n").map do |file_data|
        split_data = file_data.split(" | ")
        lib_data = { :name => split_data.first, :git => split_data[1], :revision => split_data.last }
        resolve_library(lib_data)
      end
    end # locked_libraries

    # Outputs a lock file with specific versions
    # @lockfile.generate! => ...writes lock file...
    def generate!
      f = File.new(@path, 'w')
      @depfile.libraries.each do |library|
        f.puts "#{library.name} | #{library.source} | #{library.revision}"
      end
      f.close
    end
  end # LockFile
end # Vendor