# frozen_string_literal: true

module Queries
  module User
    class Peers < GraphQL::Schema::Resolver
      argument :user_id, ID, required: true

      type [Types::UserType], null: false

      def resolve(user_id:)
        user = ::User.find(user_id)
        user.manager ? user.manager.subordinates.where.not(id: user.id) : []
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('User not found')
      end
    end
  end
end
