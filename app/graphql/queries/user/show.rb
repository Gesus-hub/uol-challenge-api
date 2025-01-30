# frozen_string_literal: true

module Queries
  module User
    class Show < GraphQL::Schema::Resolver
      argument :id, ID, required: true

      type Types::UserType, null: false

      def resolve(id:)
        ::User.kept.find(id)
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('User not found')
      end
    end
  end
end
