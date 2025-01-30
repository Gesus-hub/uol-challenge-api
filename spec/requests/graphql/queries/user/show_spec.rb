# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Queries::User::Show' do
  let(:user) { create(:user) }

  describe 'user' do
    it 'returns a user by ID' do
      query = <<~GQL
        query {
          user(id: "#{user.id}") {
            id
            name
            email
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'user', 'name')).to eq(user.name)
    end

    it 'returns an error if user does not exist' do
      query = <<~GQL
        query {
          user(id: "non-existent-id") {
            id
            name
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
