# frozen_string_literal: true

class CreateLanguageUsages < ActiveRecord::Migration[7.1]
  def change
    create_table :language_usages do |t|
      t.references :repository, null: false, foreign_key: true
      t.string :language_name
      t.integer :byte_size

      t.timestamps
    end
  end
end
