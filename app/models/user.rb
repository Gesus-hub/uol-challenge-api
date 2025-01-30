# frozen_string_literal: true

class User < ApplicationRecord
  include Discard::Model

  belongs_to :company
  belongs_to :manager, class_name: 'User', optional: true
  has_many :subordinates,
           class_name: 'User',
           foreign_key: 'manager_id',
           dependent: :nullify,
           inverse_of: :manager

  enum :role, { employee: 0, manager: 1, director: 2, executive: 3 }

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validate :manager_must_be_in_same_company
  validate :avoid_hierarchy_loops
  validate :cannot_become_manager_of_superior

  def manager_must_be_in_same_company
    return unless manager && manager.company_id != company_id

    errors.add(:manager, 'must be in the same company')
  end

  def avoid_hierarchy_loops
    return unless manager&.self_and_ancestors&.include?(self)

    errors.add(:manager, 'hierarchy loop detected')
  end

  def cannot_become_manager_of_superior
    return unless manager_id_changed? && manager&.self_and_ancestors&.include?(self)

    errors.add(:manager, 'cannot be assigned as a manager to someone higher in the hierarchy')
  end

  def self_and_ancestors(seen_users = Set.new)
    return [] if seen_users.include?(self)

    seen_users.add(self)
    manager ? [self] + manager.self_and_ancestors(seen_users) : [self]
  end
end
