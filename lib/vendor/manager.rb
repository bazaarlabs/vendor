# Manager that handles all essential vendoring functionality

module Vendor
  class Manager
    # Vendor::Manager.new("/path/to/project", :vendored_path => "path/to/project/vendored")
    # options = { :vendors_file => "/path/to/project/Vendors" }
    def initialize(current_path, options={})
      @folder = current_path
      @vendored_path = options.delete(:vendored_path) || File.join(@folder, "vendored")
      @vendors_file_path = options.delete(:vendors_file) || File.join(@folder, "Vendors")
      @lock_file_path = options.delete(:lock_file) || File.join(@folder, "Vendors.lock")
      @depfile = DependencyFile.new(@vendors_file_path)
      @lockfile = LockFile.new(@lock_file_path, @depfile)
      @xcode_handler = XcodeHandler.new(@folder)
    end

    # Installs all deps to vendored path and generates a lockfile
    # @manager.install! => ...vendor to local path and generate lock file...
    def install!
      self.vendor!
      @lockfile.generate!
    end

    # Updates the deps from Vendors, recreates Vendors.lock
    # Only for library_name if specified
    # @manager.update
    # @manager.update("three20")
    def update!(library_name=nil)
      if library_name # only library
        local_path = File.join(@vendored_path, library_name)
        FileUtils.rm_rf(local_path)
        library = @depfile.libraries.find { |l| l.name == library_name }
        library.fetch(@vendored_path)
      else # update all libs
        FileUtils.rm_rf(@vendored_path)
        self.install!
      end
    end

    # Returns the most accurate library list possible
    # @manager.libraries => [<Library>, ...]
    def libraries
      self.locked_libraries || self.required_libraries
    end

    # Returns the libraries required by Vendors file
    # @manager.required_libraries => [<Library>, ...]
    def required_libraries
      @depfile.libraries
    end

    # Returns libraries that are locked as dependencies in Vendors.lock
    # @manager.locked_libraries => [<Library>, ...]
    def locked_libraries
      @lockfile.libraries if @lockfile.exists?
    end

    # Returns libraries that are missing from local installation
    # @manager.locked_libraries => [<Library>, ...]
    def missing_libraries
      return self.required_libraries unless @lockfile.exists?
      self.locked_libraries.select do |lib|
        local_path = File.join(@vendored_path, lib.name)
        installed = @depfile.libraries.find { |l| l.name == lib.name }
        installed.nil? || installed.revision(local_path) != lib.revision
      end
    end # missing_libraries

    protected

    # Vendors the various libraries to the specified "vendored" path
    # @manager.vendor!
    def vendor!
      @depfile.sources.each   { |source| source.fetch }
      self.required_libraries.each { |library| library.fetch(@vendored_path) }
    end
  end
end