# frozen_string_literal: true

RSpec.describe 'Queries::User::SecondLevelReports' do
  let(:company) { create(:company) }
  let(:executive) { create(:user, :executive, company: company) }
  let(:manager) { create(:user, :manager, company: company, manager: executive) }
  let!(:subordinates) do
    create_list(:user, 2, :employee, company: company, manager: manager)
  end

  describe 'second_level_reports' do
    it 'returns second level reports for a user with multiple managers' do
      query = <<~GQL
        query {
          secondLevelReports(userId: "#{executive.id}") {
            id
            name
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'secondLevelReports').size).to eq(2)
      expect(json.dig('data', 'secondLevelReports').map { |u| u['id'] })
        .to contain_exactly(subordinates.first.id.to_s, subordinates.second.id.to_s)
    end

    it 'returns an empty list if user has no second level reports' do
      query = <<~GQL
        query {
          secondLevelReports(userId: "#{manager.id}") {
            id
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'secondLevelReports')).to eq([])
    end

    it 'returns an error if user does not exist' do
      query = <<~GQL
        query {
          secondLevelReports(userId: "non-existent-id") {
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
