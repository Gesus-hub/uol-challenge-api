# frozen_string_literal: true

module Types
  class QueryType < Types::BaseObject
    # Company
    field :companies, resolver: Queries::Company::Index
    field :company, resolver: Queries::Company::Show
    # User
    field :users, resolver: Queries::User::Index
    field :user, resolver: Queries::User::Show
    field :peers, resolver: Queries::User::Peers
    field :direct_reports, resolver: Queries::User::DirectReports
    field :second_level_reports, resolver: Queries::User::SecondLevelReports
  end
end
