# frozen_string_literal: true

class Company < ApplicationRecord
  include Discard::Model

  validates :name, presence: true, uniqueness: true
end
