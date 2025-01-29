# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mutations::Company' do
  describe 'createCompany' do
    it 'creates a company successfully and retrieves it via query' do
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

      created_id = json.dig('data', 'createCompany', 'id')
      expect(json.dig('data', 'createCompany', 'name')).to eq('Test Company')

      query = <<~GQL
        query {
          company(id: "#{created_id}") {
            id
            name
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'company', 'name')).to eq('Test Company')
    end
  end

  describe 'updateCompany' do
    it 'updates a company successfully' do
      company = create(:company, name: 'Old Name')
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

      expect(json.dig('data', 'company', 'name')).to eq('Updated Name')
    end
  end

  describe 'discardCompany' do
    it 'soft deletes a company and verifies it is not in active list' do
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

      active_ids = json.dig('data', 'companies')&.map { |c| c['id'] }
      expect(active_ids).not_to include(company.id.to_s)
    end
  end

  describe 'undiscardCompany' do
    it 'restores a soft-deleted company' do
      company = create(:company, discarded_at: Time.current)
      query = <<~GQL
        mutation {
          undiscardCompany(input: { id: "#{company.id}" }) {
            id
            discardedAt
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      puts "GraphQL Errors: #{json['errors']}" if json['errors']

      expect(json.dig('data', 'undiscardCompany', 'discardedAt')).to be_nil
    end
  end
end
