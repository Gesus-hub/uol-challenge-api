# frozen_string_literal: true

module Queries
  module User
    class SecondLevelReports < GraphQL::Schema::Resolver
      argument :user_id, ID, required: true

      type [Types::UserType], null: false

      def resolve(user_id:)
        user = ::User.find(user_id)
        return [] if user.subordinates.kept.empty?

        user.subordinates.kept.flat_map { |subordinate| subordinate.subordinates.kept }.compact
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('User not found')
      end
    end
  end
end
