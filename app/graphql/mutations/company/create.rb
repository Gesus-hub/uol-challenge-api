# frozen_string_literal: true

module Mutations
  module Company
    class Create < BaseMutation
      argument :name, String, required: true

      type Types::CompanyType

      def resolve(name:)
        ::Company.create!(name: name)
      rescue ActiveRecord::RecordInvalid => e
        GraphQL::ExecutionError.new(e.record.errors.full_messages.join(', '))
      end
    end
  end
end
