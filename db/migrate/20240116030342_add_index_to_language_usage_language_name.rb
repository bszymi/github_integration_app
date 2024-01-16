# frozen_string_literal: true

class AddIndexToLanguageUsageLanguageName < ActiveRecord::Migration[7.1]
  def change
    add_index :language_usages, %i[language_name repository_id], unique: true
  end
end
