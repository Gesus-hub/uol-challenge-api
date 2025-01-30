# frozen_string_literal: true

module Mutations
  module User
    class Discard < BaseMutation
      argument :id, ID, required: true

      type Types::UserType

      def resolve(id:)
        user = ::User.kept.find(id)
        user.discard
        user
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('User not found')
      end
    end
  end
end
