# frozen_string_literal: true

class User < ApplicationRecord
  include Discard::Model

  belongs_to :company

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end
