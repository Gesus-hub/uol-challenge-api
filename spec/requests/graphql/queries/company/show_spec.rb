# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Queries::Company::Show' do
  describe 'company' do
    it 'returns a company by ID' do
      company = create(:company, name: 'Test Company')

      query = <<~GQL
        query {
          company(id: "#{company.id}") {
            id
            name
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      puts "GraphQL Errors: #{json['errors']}" if json['errors']

      expect(json.dig('data', 'company', 'name')).to eq('Test Company')
    end

    it 'returns an error if company does not exist' do
      query = <<~GQL
        query {
          company(id: "non-existent-id") {
            id
            name
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json['errors']).not_to be_nil
      expect(json['errors'][0]['message']).to eq('Company not found')
    end
  end
end
