# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Queries::User::DirectReports' do
  let(:company) { create(:company) }
  let(:manager) { create(:user, :manager, company: company) }
  let!(:subordinate) { create(:user, company: company, manager: manager) }

  describe 'direct_reports' do
    it 'returns direct reports for a user' do
      query = <<~GQL
        query {
          directReports(userId: "#{manager.id}") {
            id
            name
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'directReports').size).to eq(1)
      expect(json.dig('data', 'directReports').first['id']).to eq(subordinate.id.to_s)
    end
  end
end
