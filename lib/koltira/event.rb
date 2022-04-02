# frozen_string_literal: true

module Koltira
  class Event < Koltira::Model
    attribute :id, :string, default: -> { SecureRandom.uuid }
    attribute :name, :string
    attribute :date, :datetime, default: -> { Time.now }
    attribute :data, default: -> { Hash.new }

    def self.parse(str)
      data = JSON.parse(str)
      new(
        id: data['id'],
        name: data['name'],
        date: Time.at(data['date'].to_i),
        data: data['data'] || {}
      )
    rescue JSON::ParserError => e
      raise ParserError.new(
        str, "Unable to parse JSON string: #{e.message}"
      )
    end

    def content_sha256
      Digest::SHA256.hexdigest(JSON.dump(data))
    end

    def as_json(*)
      {
        'id' => id,
        'name' => name,
        'date' => date.to_i,
        'data' => data
      }
    end

    # == Exceptions classes
    class ParserError < Koltira::Error
      attr_reader :input

      def initialize(input, message)
        @input = input
        super(message)
      end
    end
  end
end
