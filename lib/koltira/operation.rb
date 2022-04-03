# frozen_string_literal: true

module Koltira
  class Operation
    attr_reader :context

    # @param args [Hash<String, Object>]
    # @param context [Koltira::Context|NilClass]
    # @return [Koltira::Operation::Output]
    def self.call(args, context = nil)
      new(context).call(args)
    end

    # @param context [Koltira::Context|NilClass]
    def initialize(context = nil)
      @context = context
    end

    # Operation call function
    # @param args [Hash<String, Object>] A dictionnary of key (string) and value (any object) pairs
    # @raise [Koltira::Operation::Error]
    # @return [Koltira::Operation::Output]
    def call(args)
      raise "#call not implemented in #{self.class}"
    end

    # generic operation error exception class
    class Error < ::Koltira::Error
      attr_reader :data

      def initialize(message, data = {})
        @data = data
        super(message)
      end
    end

    # output operation class
    class Output
      def initialize(data = {})
        unless data.is_a?(Hash)
          raise ArgumentError, "Hash expected, got: #{data.class}"
        end

        @data = data
      end

      def [](key)
        @data[key]
      end

      def []=(key, value)
        @data[key] = value
      end

      def to_json(*args)
        @data.to_json(*args)
      end

      def as_json(*args)
        @data.as_json(*args)
      end
    end
  end
end
