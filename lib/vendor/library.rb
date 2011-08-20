module Vendor
  class Library
    extend Vendor::ClassProperty

    class_property :source
    class_property :header_path
    class_property :libraries
    class_property :frameworks
    class_property :linker_flags
    class_property :vendors

    attr_reader :name, :local_path

    # Vendor::Library.new("three20", [<source>, <source>], { })
    def initialize(name, options={})
      @name = name
      @options = { :git => self.class.source }.merge(options)
    end

    def fetch(target_path)
      if @options.has_key?(:git)
        self.fetch_git(target_path)
      end # fetch_git
    end # fetch

    def source
      @options[:git]
    end

    def revision(target_path = self.local_path)
      return nil unless target_path
      return nil unless File.exist?(target_path.to_s + "/.git")
      @grit = Grit::Repo.new(target_path)
      @grit.commits('master', 1).first.sha
    end

    def to_hash
      { :name => self.name, :revision => revision, :source => self.source }
    end

    protected

    def fetch_git(target_path)
      @local_path = File.join(target_path, @name)
      if self.revision.nil? # no local copy
        puts "fetching #{self.name} from #{self.source}"
        puts `git clone #{self.source} #{@local_path}`
      end
    end # fetch_git
  end
end