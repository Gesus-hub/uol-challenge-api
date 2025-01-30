# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Queries::User::Index' do
  let(:company) { create(:company) }
  let!(:users) { create_list(:user, 3, company: company) }
  let!(:empty_company) { create(:company) }

  describe 'users' do
    it 'returns a list of users for a specific company' do
      query = <<~GQL
        query {
          users(companyId: "#{company.id}") {
            id
            name
            email
            role
            manager {
              id
            }
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'users').size).to eq(3)
      expect(json.dig('data', 'users').map { |u| u['id'] }).to match_array(users.map { |u| u.id.to_s })
    end

    it 'returns an empty list if the company has no users' do
      query = <<~GQL
        query {
          users(companyId: "#{empty_company.id}") {
            id
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'users')).to be_empty
    end

    it 'returns an error if company does not exist' do
      query = <<~GQL
        query {
          users(companyId: "non-existent-id") {
            id
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
