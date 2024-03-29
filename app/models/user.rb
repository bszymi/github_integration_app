# frozen_string_literal: true

class User < ApplicationRecord
  has_many :repositories

  validates :username, presence: true, uniqueness: { case_sensitive: false }
end
