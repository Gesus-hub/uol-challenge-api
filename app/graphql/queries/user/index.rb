# frozen_string_literal: true

module Queries
  module User
    class Index < GraphQL::Schema::Resolver
      argument :company_id, ID, required: true

      type [Types::UserType], null: false

      def resolve(company_id:)
        company = ::Company.find_by(id: company_id)
        return GraphQL::ExecutionError.new('Company not found') unless company

        company.users.kept
      end
    end
  end
end
