require 'grit'
require File.expand_path(File.dirname(__FILE__) + '/vendor/version')
require File.expand_path(File.dirname(__FILE__) + '/vendor/helpers')
require File.expand_path(File.dirname(__FILE__) + '/vendor/class_property')
require File.expand_path(File.dirname(__FILE__) + '/vendor/library')
require File.expand_path(File.dirname(__FILE__) + '/vendor/source')
require File.expand_path(File.dirname(__FILE__) + '/vendor/dependency_file')
require File.expand_path(File.dirname(__FILE__) + '/vendor/cli')
Dir[File.expand_path(File.dirname(__FILE__) + '/vendor/libraries/*.rb')].each do |lib|
  require lib
end

module Vendor
  # Nothing here yet
end