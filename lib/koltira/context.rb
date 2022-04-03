# frozen_string_literal: true

module Koltira
  class Context
    attr_reader :data

    def initialize(data = {})
      @data = data
    end

    def [](key)
      @data[key]
    end

    def []=(key, value)
      @data[key] = value
    end

    def reset!
      @data = {}
    end

    def dup
      new(@data.dup)
    end
  end
end
