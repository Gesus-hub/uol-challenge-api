# frozen_string_literal: true

module Mutations
  module User
    class Undiscard < BaseMutation
      argument :id, ID, required: true

      type Types::UserType

      def resolve(id:)
        user = ::User.discarded.find(id)
        user.undiscard
        user
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('User not found')
      end
    end
  end
end
