# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User do
  describe 'associations' do
    it { is_expected.to belong_to(:company) }
    it { is_expected.to belong_to(:manager).optional }
    it { is_expected.to have_many(:subordinates).class_name('User') }
  end

  describe 'validations' do
    subject { create(:user) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
  end

  describe 'custom validations' do
    let(:company) { create(:company) }
    let(:another_company) { create(:company) }
    let(:manager) { create(:user, company: company) }
    let(:employee) { create(:user, company: company, manager: manager) }
    let(:external_manager) { create(:user, company: another_company) }

    describe '#manager_must_be_in_same_company' do
      it 'allows manager from the same company' do
        expect(employee.valid?).to be true
      end

      it 'does not allow manager from a different company' do
        employee.manager = external_manager
        expect(employee.valid?).to be false
        expect(employee.errors[:manager]).to include('must be in the same company')
      end
    end

    describe '#avoid_hierarchy_loops' do
      it 'does not allow a user to be their own manager' do
        employee.manager = employee
        expect(employee.valid?).to be false
        expect(employee.errors[:manager]).to include('hierarchy loop detected')
      end

      it 'does not allow circular hierarchy' do
        manager.manager = employee
        expect(manager.valid?).to be false
        expect(manager.errors[:manager]).to include('hierarchy loop detected')
      end
    end
  end

  describe '#self_and_ancestors' do
    let(:company) { create(:company) }
    let(:grand_manager) { create(:user, company: company) }
    let(:manager) { create(:user, company: company, manager: grand_manager) }
    let(:employee) { create(:user, company: company, manager: manager) }

    it 'returns the correct hierarchy' do
      expect(employee.self_and_ancestors).to contain_exactly(employee, manager, grand_manager)
    end
  end
end
