# Thor CLI running `vendor` binary
module Vendor
  class Cli < Thor
    include Thor::Actions

    # vendor install --path . --file Vendors
    desc "install", "Installs the dependencies specified in the Vendors file"
    method_option :file, :default => "./Vendors", :aliases => "-f"
    method_option :path, :default => ".", :aliases => "-p"
    def install
      manager = Vendor::Manager.new(options[:path], :vendors_file_path => options[:file])
      manager.install!
      say "Vendored libraries have been installed", :green
    end # install

    # vendor update
    # vendor update facebook-ios-sdk
    desc "update LIB_NAME", "Updates the dependency specified in the Vendors file"
    def update(lib_name=nil)
      manager = Vendor::Manager.new(Dir.pwd)
      manager.update!(lib_name)
    end # update

    # vendor list
    desc "list", "Lists the dependencies specified for this project"
    def list
      manager = Vendor::Manager.new(Dir.pwd)
      say "Dependencies:\n"
      manager.libraries.each do |lib|
        say "  #{lib}", :yellow
      end
    end

    # vendor check
    desc "check", "Checks which dependencies are satisfied"
    def check
      manager = Vendor::Manager.new(Dir.pwd)
      missing = manager.missing_libraries
      if missing.any?
        puts "Missing:\n"
        missing.each { |lib| say lib, :yellow }
      else # all met
        say "All dependencies have been satisfied", :green
      end
    end # check
  end # CLI
end