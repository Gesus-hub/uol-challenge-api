# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_company, mutation: Mutations::Company::Create
    field :update_company, mutation: Mutations::Company::Update
    field :discard_company, mutation: Mutations::Company::Discard
    field :undiscard_company, mutation: Mutations::Company::Undiscard
    field :create_user, mutation: Mutations::User::Create
    field :update_user, mutation: Mutations::User::Update
    field :discard_user, mutation: Mutations::User::Discard
    field :undiscard_user, mutation: Mutations::User::Undiscard
  end
end
