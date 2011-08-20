module Vendor
  class DependencyFile
    include Vendor::Helpers

    attr_reader :sources

    def initialize(file_path)
      @file_path = file_path
      @folder = File.dirname(@file_path)
      @vendored_path = File.join(@folder, "vendored")
      @text = File.read(file_path)
      @sources = []
      @libs = []
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

    # Returns libraries based on specified information and formulae
    def libraries
      @_libraries ||= @libs.map do |lib_data|
        if lib_data[:git]
          Vendor::Library.new(lib_data.delete(:name), lib_data)
        else # assume local source
          klazz_name = lib_data[:class] || camelize_word(lib_data[:name].gsub(/-/, '_'))
          klazz = eval(klazz_name) rescue nil
          raise "Cannot find formula #{klazz_name.inspect}" unless klazz
          klazz.new(lib_data[:name])
        end
      end # libs
    end # libraries

    # Vendors the various libraries to the specified path
    def vendor!
      FileUtils.mkdir_p(@vendored_path)
      self.sources.each { |source| source.fetch }
      self.libraries.each { |library| library.fetch(@vendored_path) }
    end

    # Outputs a lock file with specific versions
    def lock!
      f = File.new(@file_path + ".lock", 'w')
      self.libraries.each do |library|
        f.puts "#{library.name} | #{library.source} | #{library.revision}"
      end
      f.close
    end

    # Returns libraries specified in Vendor.lock
    def locked_libraries
      return self.libraries.map { |lib| lib.to_hash } unless File.exist?(@file_path + ".lock")
      File.read(@file_path + ".lock").split("\n").map do |file_data|
        split_data = file_data.split(" | ")
        { :name => split_data.first, :source => split_data[1], :revision => split_data.last }
      end
    end

    # Returns libraries that are missing from local installation
    def missing_libraries
      return self.libraries.map { |lib| lib.to_hash } unless File.exist?(@file_path + ".lock")
      self.locked_libraries.select do |lib|
        local_path = File.join(@vendored_path, lib[:name])
        installed = self.libraries.find { |l| l.name == lib[:name] }
        installed.nil? || (installed.revision(local_path) != lib[:revision])
      end
    end
  end # DependencyFile
end # Vendor