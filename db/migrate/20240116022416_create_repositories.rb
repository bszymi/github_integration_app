# frozen_string_literal: true

class CreateRepositories < ActiveRecord::Migration[7.1]
  def change
    create_table :repositories do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.integer :star_count

      t.timestamps
    end
  end
end
