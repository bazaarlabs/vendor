module Vendor
  class Library
    extend Vendor::ClassProperty

    class_property :source
    class_property :header_path
    class_property :libraries
    class_property :frameworks
    class_property :linker_flags
    class_property :vendors

    attr_reader :name, :source, :local_path

    # Vendor::Library.new("three20", [<source>, <source>], { })
    # Construct new instance of a library
    def initialize(name, options={})
      @name = name
      @options = options
      @source = @options[:git] || self.class.source
      @revision = @options[:revision]
    end

    # Downloads remote library to vendored path
    # @library.fetch("/path/to/project/vendored")
    def fetch(vendored_path)
      if @source && @source =~ /\.git$/
        self.fetch_git(vendored_path)
      end # fetch_git
    end # fetch

    # Retrieves the revision number for this library
    # @library.revision => "c1b3hg7"
    def revision(library_path = self.local_path)
      @revision ||= begin
        missing_git_repo = !File.exist?(library_path.to_s + "/.git")
        return if library_path.nil? || missing_git_repo
        grit = Grit::Repo.new(library_path)
        grit.commits('master', 1).first.sha
      end
    end

    # Returns enhanced to_s string representation
    def to_s
      "Library: #{self.name} (#{self.source}) [#{self.revision}]"
    end

    protected

    # Downloads remote library to vendored path from git repo (if needed)
    # @library_path.fetch_git("/path/to/project/vendored")
    def fetch_git(vendored_path)
      @local_path = File.join(vendored_path, @name)
      if self.revision.nil? # no local copy
        FileUtils.mkdir_p(vendored_path)
        puts "fetching #{self.name} from #{self.source}"
        puts `git clone #{self.source} #{@local_path}`
      end
    end # fetch_git
  end # Library
end # Vendor