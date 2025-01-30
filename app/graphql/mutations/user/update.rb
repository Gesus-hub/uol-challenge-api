# frozen_string_literal: true

module Mutations
  module User
    class Update < BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false

      type Types::UserType

      def resolve(id:, name: nil, email: nil)
        user = ::User.kept.find(id)
        user.update!(name: name, email: email)
        user
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.full_messages.join(', '))
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('User not found')
      end
    end
  end
end
