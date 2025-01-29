# frozen_string_literal: true

module Types
  class CompanyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :discarded_at, GraphQL::Types::ISO8601DateTime, null: true
  end
end
