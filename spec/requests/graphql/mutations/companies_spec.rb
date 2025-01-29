# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mutations::Company' do
  describe 'createCompany' do
    it 'creates a company successfully' do
      query = <<~GQL
        mutation {
          createCompany(input: { name: "Test Company" }) {
            id
            name
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      puts "GraphQL Errors: #{json['errors']}" if json['errors']

      expect(json.dig('data', 'createCompany', 'name')).to eq('Test Company')
    end
  end

  describe 'updateCompany' do
    it 'updates a company successfully' do
      company = create(:company)
      query = <<~GQL
        mutation {
          updateCompany(input: { id: "#{company.id}", name: "Updated Name" }) {
            id
            name
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      puts "GraphQL Errors: #{json['errors']}" if json['errors']

      expect(json.dig('data', 'updateCompany', 'name')).to eq('Updated Name')
    end
  end

  describe 'discardCompany' do
    it 'soft deletes a company' do
      company = create(:company)
      query = <<~GQL
        mutation {
          discardCompany(input: { id: "#{company.id}" }) {
            id
            discardedAt
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      puts "GraphQL Errors: #{json['errors']}" if json['errors']

      expect(json.dig('data', 'discardCompany', 'discardedAt')).not_to be_nil
    end
  end
end
