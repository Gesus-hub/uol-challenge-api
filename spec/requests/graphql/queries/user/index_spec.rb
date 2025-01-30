# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Queries::User::Index' do
  let(:company) { create(:company) }

  before { create_list(:user, 3, company: company) }

  describe 'users' do
    it 'returns a list of users for a company' do
      query = <<~GQL
        query {
          users(companyId: "#{company.id}") {
            id
            name
            email
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'users').size).to eq(3)
    end
  end
end
