# frozen_string_literal: true

module Mutations
  module User
    class AssignManager < BaseMutation
      argument :user_id, ID, required: true
      argument :manager_id, ID, required: true

      type Types::UserType

      def resolve(user_id:, manager_id:)
        user = ::User.find(user_id)
        manager = ::User.find(manager_id)

        raise GraphQL::ExecutionError, 'Manager must be in the same company' if user.company_id != manager.company_id

        raise GraphQL::ExecutionError, 'Hierarchy loop detected' if manager.self_and_ancestors.include?(user)

        user.update!(manager: manager)
        user
      rescue ActiveRecord::RecordNotFound
        raise GraphQL::ExecutionError, 'User or Manager not found'
      rescue ActiveRecord::RecordInvalid => e
        raise GraphQL::ExecutionError, e.record.errors.full_messages.join(', ')
      end
    end
  end
end
