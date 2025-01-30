# frozen_string_literal: true

module Queries
  module User
    class DirectReports < GraphQL::Schema::Resolver
      argument :user_id, ID, required: true

      type [Types::UserType], null: false

      def resolve(user_id:)
        user = ::User.find(user_id)
        user.subordinates.kept
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('User not found')
      end
    end
  end
end
