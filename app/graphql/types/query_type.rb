# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :companies, resolver: Queries::Company::Index
    field :company, resolver: Queries::Company::Show
    field :users, resolver: Queries::User::Index
    field :user, resolver: Queries::User::Show
  end
end
