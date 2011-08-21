=begin

Used to define getter/setter properties at the class level

class Example
  include Vendor::ClassProperty

  class_property :name
  # Example.name("foo", "bar")
  # Example.name => ["foo", "bar"]
  # @example.name => ["foo", "bar"]
end

Used primarily for simple DSLs when defining class values

=end

module Vendor
  module ClassProperty

    # Define getter/setter properties at the class level
    def class_property(name)
      self.metaclass.instance_eval do
        define_method(name) do |*args|
          if args.any? && args.length == 1
            self.instance_variable_set(:"@#{name}", args.first)
          elsif  args.any? && args.length > 1
            self.instance_variable_set(:"@#{name}", args)
          else # retrieve
            self.instance_variable_get(:"@#{name}")
          end
        end
      end

      # Creates instance level method returning same value
      define_method(name) do
        self.class.send(name)
      end
    end # class_property
  end # ClassProperty
end # Vendor
