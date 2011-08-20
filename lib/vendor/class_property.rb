module Vendor
  module ClassProperty
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

      define_method(name) do
        self.class.send(name)
      end
    end # class_property
  end # ClassProperty
end # Vendor
