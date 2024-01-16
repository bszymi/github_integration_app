class LanguageUsage < ApplicationRecord
  belongs_to :repository

  validates :language_name, presence: true, uniqueness: { scope: :repository_id, case_sensitive: false }
end
