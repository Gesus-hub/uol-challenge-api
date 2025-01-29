# frozen_string_literal: true

module Types
  class MutationType < Types::BaseObject
    field :create_company, mutation: Mutations::Company::Create
    field :update_company, mutation: Mutations::Company::Update
    field :discard_company, mutation: Mutations::Company::Discard
    field :undiscard_company, mutation: Mutations::Company::Undiscard
  end
end
