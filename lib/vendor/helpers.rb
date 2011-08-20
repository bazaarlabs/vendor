module Vendor
  module Helpers
    def camelize_word(lower_case_and_underscored_word)
      lower_case_and_underscored_word.to_s.gsub(/\/(.?)/) { "::#{$1.upcase}" }.gsub(/(?:^|_)(.)/) { $1.upcase }
    end
  end
end

class Object
  def metaclass
    class << self; self; end
  end unless Object.method_defined?(:metaclass)
end