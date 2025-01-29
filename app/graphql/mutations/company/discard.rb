# frozen_string_literal: true

module Mutations
  module Company
    class Discard < BaseMutation
      argument :id, ID, required: true

      type Types::CompanyType

      def resolve(id:)
        company = ::Company.kept.find(id)
        company.discard
        company
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('Company not found')
      end
    end
  end
end
