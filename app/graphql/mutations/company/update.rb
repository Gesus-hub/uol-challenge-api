# frozen_string_literal: true

module Mutations
  module Company
    class Update < BaseMutation
      argument :id, ID, required: true
      argument :name, String, required: true

      type Types::CompanyType

      def resolve(id:, name:)
        company = ::Company.kept.find(id)
        company.update!(name: name)
        company
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.full_messages.join(', '))
      end
    end
  end
end
