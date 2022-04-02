# frozen_string_literal: true

module Koltira
  class Model
    include ActiveModel::Model
    include ActiveModel::Attributes
    include ActiveModel::AttributeMethods
    include ActiveModel::Serialization
    include ActiveModel::Serializers::JSON

    def self.from_database(arg)
      new._from_database(arg)
    end

    def _from_database(arg)
      arg.each do |key, value|
        @attributes.write_from_database(key.name, value)
      end
      self
    end
  end
end
