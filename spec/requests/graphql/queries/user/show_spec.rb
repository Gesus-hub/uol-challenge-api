# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Queries::User::Show' do
  let(:company) { create(:company) }
  let!(:manager) { create(:user, company: company, role: :manager) }
  let!(:user) { create(:user, company: company, manager: manager) }

  describe 'user' do
    it 'returns a user by ID with all fields' do
      query = <<~GQL
        query {
          user(id: "#{user.id}") {
            id
            name
            email
            role
            manager {
              id
              name
            }
            company {
              id
              name
            }
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'user', 'name')).to eq(user.name)
      expect(json.dig('data', 'user', 'role')).to eq('employee')
      expect(json.dig('data', 'user', 'manager', 'id')).to eq(manager.id.to_s)
      expect(json.dig('data', 'user', 'manager', 'name')).to eq(manager.name)
      expect(json.dig('data', 'user', 'company', 'id')).to eq(company.id.to_s)
      expect(json.dig('data', 'user', 'company', 'name')).to eq(company.name)
    end

    it 'returns an error if user does not exist' do
      query = <<~GQL
        query {
          user(id: "non-existent-id") {
            id
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json['errors']).not_to be_nil
      expect(json['errors'][0]['message']).to eq('User not found')
    end
  end
end
