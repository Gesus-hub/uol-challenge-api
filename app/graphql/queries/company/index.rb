# frozen_string_literal: true

module Queries
  module Company
    class Index < GraphQL::Schema::Resolver
      type [Types::CompanyType], null: false

      def resolve
        ::Company.kept
      end
    end
  end
end
