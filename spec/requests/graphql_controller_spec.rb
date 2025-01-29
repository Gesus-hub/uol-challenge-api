# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GraphqlController do
  describe 'POST /graphql' do
    let(:query) do
      <<~GQL
        query {
          __typename
        }
      GQL
    end

    it 'returns HTTP status :ok (200)' do
      post '/graphql', params: { query: query }

      expect(response).to have_http_status(:ok)
    end

    it 'returns a valid JSON response' do
      post '/graphql', params: { query: query }

      json_response = response.parsed_body
      expect(json_response).to have_key('data')
      expect(json_response['data']['__typename']).to eq('Query')
    end
  end
end
