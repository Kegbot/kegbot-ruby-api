require 'active_support/concern'

module KegbotApi
  # Provides methods for specifying, storing, and retriving REST noun attributes and relationships.
  # @see RestNoun
  module RestNounAttributes
    extend ActiveSupport::Concern

    included do
      attr_accessor :attributes
    end

    module ClassMethods
      # Defines an id field for this REST noun
      def id(name, *args)
        define_accessor  name
      end

      # Defines a {String} field for this REST noun
      def string(name, *args)
        define_accessor  name
      end

      # Defines a {Float} field for this REST noun
      def float(name, *args)
        define_accessor name, *args
      end

      # Defines a {Fixnum} field for this REST noun
      def integer(name, *args)
        define_accessor name
      end

      # Defines a 1-1 relationship between this Noun and another.
      # @overload has_one(name, options = {})
      def has_one(name, *args)
        options = args.slice!(0) || {}
        class_name = options[:class_name] || name.capitalize
        attribute_name = options[:attribute_name] || name
        key = attribute_name.to_s
        aliases = options[:alias]

        define_method(name) do
          if self.attributes.include? key
            self.client.noun_class(class_name).new self.attributes[key]
          else
            nil
          end
        end
        alias_method aliases.to_sym, name.to_sym if aliases
      end

      # Defines a boolean field for this REST noun, available at name?
      # @overload boolean(name, options = {})
      def boolean(name, *args)
        options = args.slice!(0) || {}
        attribute_name = options[:attribute_name] || name
        key = attribute_name.to_s

        define_method("#{name}?") do
          self.attributes[key]
        end
      end

      # Defines a Time field for this REST noun.
      # The time must be defined as a string in the REST JSON in ISO8601 format
      def time(name, *args)
        define_method(name) do
          if self.attributes.include? name.to_s
            DateTime.iso8601(self.attributes[name.to_s]).to_time
          else
            nil
          end

        end
      end

      # Defines a NOUN attribute of a URL
      # In the REST JSON, the URL my be relative or absolute.  If relative, it will get appended to the client's base_url host.
      # @overload url(name, options = {})
      def url(name, *args)
        options = args.slice!(0) || {}
        attribute_name = options[:attribute_name] || name
        key = attribute_name.to_s

        define_method("#{name}") do
          path = self.attributes[key]

          if path
            uri = URI(path)

            if uri.absolute?
              uri.to_s
            else
              # merge this URI with the client path
              base_uri = URI(self.client.base_url)

              klass = base_uri.scheme == 'http' ? URI::HTTP : URI::HTTPS
              klass.build(:host => base_uri.host, :path => path).to_s
            end
          else
            nil
          end
        end
      end

      # Defines an attribute accessor with the specified name, returning the value of {#attribute} value with key +name+
      def define_accessor(name, *args)
        options = args.slice!(0) || {}
        attribute_name = options[:attribute_name] || name
        aliases = options[:alias]

        define_method(name) do
          self.attributes[attribute_name.to_s]
        end
        alias_method aliases.to_sym, name.to_sym if aliases
      end
    end
  end
end