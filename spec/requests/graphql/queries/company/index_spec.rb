# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Queries::Company::Index' do
  describe 'companies' do
    it 'returns a list of companies' do
      create_list(:company, 3)
      query = <<~GQL
        query {
          companies {
            id
            name
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      puts "GraphQL Errors: #{json['errors']}" if json['errors']

      expect(json.dig('data', 'companies').size).to eq(3)
    end
  end
end
