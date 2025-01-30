# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Queries::User::Peers' do
  let(:company) { create(:company) }
  let(:manager) { create(:user, :manager, company: company) }
  let(:user) { create(:user, company: company, manager: manager) }
  let!(:peer) { create(:user, company: company, manager: manager) }

  describe 'peers' do
    it 'returns peers for a user' do
      query = <<~GQL
        query {
          peers(userId: "#{user.id}") {
            id
            name
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'peers').size).to eq(1)
      expect(json.dig('data', 'peers').first['id']).to eq(peer.id.to_s)
    end
  end
end
