# frozen_string_literal: true

module Queries
  module User
    class Index < GraphQL::Schema::Resolver
      argument :company_id, ID, required: true

      type [Types::UserType], null: false

      def resolve(company_id:)
        ::User.kept.where(company_id: company_id)
      end
    end
  end
end
