# frozen_string_literal: true

class Repository < ApplicationRecord
  belongs_to :user
  has_many :language_usages

  validates :name, presence: true, uniqueness: { scope: :user_id, case_sensitive: false }
end
