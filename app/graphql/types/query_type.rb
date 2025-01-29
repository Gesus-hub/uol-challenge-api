# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    field :companies, resolver: Queries::Company::Index
    field :company, resolver: Queries::Company::Show
  end
end
