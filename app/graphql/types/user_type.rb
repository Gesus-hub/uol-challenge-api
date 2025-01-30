# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :name, String, null: false
    field :email, String, null: false
    field :role, String, null: false
    field :company, Types::CompanyType, null: false
    field :manager, Types::UserType, null: true
    field :subordinates, [Types::UserType], null: true
    field :discarded_at, GraphQL::Types::ISO8601DateTime, null: true

    def role_to_string
      object.role
    end
  end
end
