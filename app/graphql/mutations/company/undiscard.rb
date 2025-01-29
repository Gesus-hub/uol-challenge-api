# frozen_string_literal: true

module Mutations
  module Company
    class Undiscard < BaseMutation
      argument :id, ID, required: true

      type Types::CompanyType

      def resolve(id:)
        company = ::Company.discarded.find(id)
        company.undiscard
        company
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('Company not found')
      end
    end
  end
end
