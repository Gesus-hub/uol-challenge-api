# frozen_string_literal: true

module Queries
  module Company
    class Show < GraphQL::Schema::Resolver
      argument :id, ID, required: true

      type Types::CompanyType, null: false

      def resolve(id:)
        ::Company.kept.find(id)
      rescue ActiveRecord::RecordNotFound
        GraphQL::ExecutionError.new('Company not found')
      end
    end
  end
end
