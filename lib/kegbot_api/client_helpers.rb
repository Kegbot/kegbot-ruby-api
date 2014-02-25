require 'active_support/concern'

module KegbotApi
  # Helper methods to be extended from {Client}
  module ClientHelpers
    extend ActiveSupport::Concern

    # Returns RestNoun subclass by name
    # @param [String, Symbol] noun name, ie: +Drink+, +Tap+
    # @return [RestNoun] noun configured for this client
    # @visibility private
    def noun_class(name)
      self.send(name)
    end

    module ClassMethods
      # Creates a method with the same name as the specified `klass`, returning a new instance of the klass specialized
      # for this {Client} instance.
      # @param [Class] klass a class instance (ie: {Drink}, {Keg}, etc.)
      # @visibility private
      def noun(klass)
        short_name = klass.name.split('::').last

        define_method(short_name) do
          klazz = klass.clone
          klazz.client = self

          klazz
        end
      end
    end
  end
end