# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    # Company
    field :create_company, mutation: Mutations::Company::Create
    field :update_company, mutation: Mutations::Company::Update
    field :discard_company, mutation: Mutations::Company::Discard
    field :undiscard_company, mutation: Mutations::Company::Undiscard
    # User
    field :create_user, mutation: Mutations::User::Create
    field :update_user, mutation: Mutations::User::Update
    field :discard_user, mutation: Mutations::User::Discard
    field :undiscard_user, mutation: Mutations::User::Undiscard
    field :assign_manager, mutation: Mutations::User::AssignManager
  end
end
