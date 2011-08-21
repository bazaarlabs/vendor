# Vendor helpers for the different library functions

module Vendor
  module Helpers
    # resolve_library(:name => "foo", :git => "http://path/to/repo.git") => <Library name=foo>
    # resolve_library(:name => "baz", :class => "BazLib") => <BazLib name=baz>
    def resolve_library(lib_data)
      lib_data = lib_data.dup
      if lib_data[:git] # simple git library
        Vendor::Library.new(lib_data.delete(:name), lib_data)
      else # defined library
        klazz_name = lib_data[:class] || camelize_word(lib_data[:name].gsub(/-/, '_'))
        klazz = eval(klazz_name) rescue nil
        raise "Cannot find formula #{klazz_name.inspect}" unless klazz
        klazz.new(lib_data[:name], lib_data)
      end # find library instance
    end

    # camelize_word("lower_case_lib") => "LowerCaseLib"
    def camelize_word(lower_case_and_underscored_word)
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) {
        "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    end
  end
end

class Object
  def metaclass
    class << self; self; end
  end unless Object.method_defined?(:metaclass)
end