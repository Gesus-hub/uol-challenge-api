# frozen_string_literal: true

module Mutations
  module User
    class Create < BaseMutation
      argument :name, String, required: true
      argument :email, String, required: true
      argument :company_id, ID, required: true

      type Types::UserType

      def resolve(name:, email:, company_id:)
        ::User.create!(name: name, email: email, company_id: company_id)
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.full_messages.join(', '))
      end
    end
  end
end
