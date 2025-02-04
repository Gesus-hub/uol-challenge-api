# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Company do
  describe 'associations' do
    it { is_expected.to have_many(:users).dependent(:destroy) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
