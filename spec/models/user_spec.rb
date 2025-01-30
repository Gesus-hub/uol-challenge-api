# frozen_string_literal: true

RSpec.describe User do
  describe 'custom validations' do
    let(:company) { create(:company) }
    let(:another_company) { create(:company) }

    let(:users) do
      {
        executive: create(:user, company: company, role: :executive),
        director: create(:user, company: company, role: :director),
        manager: create(:user, company: company, role: :manager),
        employee: create(:user, company: company, role: :employee),
        external_manager: create(:user, company: another_company)
      }
    end

    before do
      users[:director].update(manager: users[:executive])
      users[:manager].update(manager: users[:director])
      users[:employee].update(manager: users[:manager])
    end

    describe '#manager_must_be_in_same_company' do
      it 'allows manager from the same company' do
        expect(users[:employee].valid?).to be true
      end

      it 'does not allow manager from a different company' do
        users[:employee].manager = users[:external_manager]
        expect(users[:employee].valid?).to be false
        expect(users[:employee].errors[:manager]).to include('must be in the same company')
      end
    end

    describe '#avoid_hierarchy_loops' do
      it 'does not allow a user to be their own manager' do
        users[:employee].manager = users[:employee]
        expect(users[:employee].valid?).to be false
        expect(users[:employee].errors[:manager]).to include('hierarchy loop detected')
      end

      it 'does not allow circular hierarchy' do
        users[:manager].manager = users[:employee]
        expect(users[:manager].valid?).to be false
        expect(users[:manager].errors[:manager]).to include('hierarchy loop detected')
      end
    end

    describe '#cannot_become_manager_of_superior' do
      it 'does not allow a subordinate to be assigned as a manager of a superior' do
        users[:director].manager = users[:employee]
        expect(users[:director].valid?).to be false
        expect(users[:director].errors[:manager])
          .to include('cannot be assigned as a manager to someone higher in the hierarchy')
      end
    end
  end

  describe '#self_and_ancestors' do
    let(:company) { create(:company) }
    let(:executive) { create(:user, :executive, company: company) }
    let(:director) { create(:user, :director, company: company, manager: executive) }
    let(:manager) { create(:user, :manager, company: company, manager: director) }
    let(:employee) { create(:user, :employee, company: company, manager: manager) }

    it 'returns the correct hierarchy' do
      expect(employee.self_and_ancestors).to contain_exactly(employee, manager, director, executive)
    end
  end
end
