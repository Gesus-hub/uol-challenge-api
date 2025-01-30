# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Mutations::User' do
  let(:user) { create(:user) }
  let(:company) { create(:company) }

  describe 'createUser' do
    it 'creates a user successfully' do
      query = <<~GQL
        mutation {
          createUser(input: { name: "John Doe", email: "john@example.com", companyId: "#{company.id}" }) {
            id
            name
            email
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'createUser', 'name')).to eq('John Doe')
    end
  end

  describe 'updateUser' do
    it 'updates a user successfully' do
      query = <<~GQL
        mutation {
          updateUser(input: { id: "#{user.id}", name: "Updated Name", email: "updated@example.com" }) {
            id
            name
            email
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'updateUser', 'name')).to eq('Updated Name')
      expect(json.dig('data', 'updateUser', 'email')).to eq('updated@example.com')
    end
  end

  describe 'discardUser' do
    it 'soft deletes a user' do
      query = <<~GQL
        mutation {
          discardUser(input: { id: "#{user.id}" }) {
            id
            discardedAt
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'discardUser', 'discardedAt')).not_to be_nil
    end
  end

  describe 'undiscardUser' do
    before { user.discard }

    it 'restores a soft-deleted user' do
      query = <<~GQL
        mutation {
          undiscardUser(input: { id: "#{user.id}" }) {
            id
            discardedAt
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'undiscardUser', 'discardedAt')).to be_nil
    end
  end

  describe 'assignManager' do
    let(:company) { create(:company) }
    let(:manager) { create(:user, :manager, company: company) }
    let(:employee) { create(:user, :employee, company: company) }

    it 'assigns a manager to a user' do
      query = <<~GQL
        mutation {
          assignManager(input: { userId: "#{employee.id}", managerId: "#{manager.id}" }) {
            id
            manager {
              id
              name
            }
          }
        }
      GQL

      post '/graphql', params: { query: query }
      json = response.parsed_body

      expect(json.dig('data', 'assignManager', 'manager', 'id')).to eq(manager.id.to_s)
    end
  end
end
