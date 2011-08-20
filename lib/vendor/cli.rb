module Vendor
  class Cli < Thor
    include Thor::Actions
    include Vendor::Helpers

    # vendor install --path . --file Vendors
    desc "install", "Installs the dependencies specified in the Vendors file"
    method_option :file, :default => "Vendors", :aliases => "-f"
    method_option :path, :default => Dir.pwd, :aliases => "-p"
    def install
      depfile = Vendor::DependencyFile.new(File.join(options[:path], options[:file]))
      depfile.vendor!
      depfile.lock!
      say "Vendored libraries have been installed", :green
    end # install

    # vendor update
    # vendor update facebook-ios-sdk
    desc "update GEM_NAME", "Updates the dependency specified in the Vendors file"
    def update

    end # update

    # vendor list
    desc "list", "Lists the dependencies specified for this project"
    method_option :file, :default => "Vendors", :aliases => "-f"
    method_option :path, :default => Dir.pwd, :aliases => "-p"
    def list
      depfile = Vendor::DependencyFile.new(File.join(options[:path], options[:file]))
      say "Dependencies:\n"
      depfile.locked_libraries.each do |lib|
        say "  #{lib[:name]} [#{lib[:revision]}] at (#{lib[:source]})", :yellow
      end
    end

    # vendor check
    desc "check", "Checks which dependencies are satisfied"
    method_option :file, :default => "Vendors", :aliases => "-f"
    method_option :path, :default => Dir.pwd, :aliases => "-p"
    def check
      depfile = Vendor::DependencyFile.new(File.join(options[:path], options[:file]))
      missing = depfile.missing_libraries
      if missing.any?
        puts "Missing:\n"
        missing.each { |lib| say "#{lib[:name]} (#{lib[:source]}) [#{lib[:revision]}]", :yellow }
      else # all met
        say "All dependencies have been satisfied", :green
      end
    end
  end # CLI
end