# frozen_string_literal: true

class Company < ApplicationRecord
  include Discard::Model

  has_many :users, dependent: :destroy

  validates :name, presence: true
end
