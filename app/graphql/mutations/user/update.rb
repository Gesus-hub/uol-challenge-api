# frozen_string_literal: true

module Mutations
  module User
    class Update < BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: false
      argument :email, String, required: false
      argument :manager_id, ID, required: false
      argument :role, Integer, required: false

      type Types::UserType

      def resolve(id:, name: nil, email: nil, manager_id: nil, role: nil)
        user = ::User.kept.find(id)
        user.update!(name: name, email: email, manager_id: manager_id, role: role)
        user
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.full_messages.join(', '))
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('User not found')
      end
    end
  end
end
