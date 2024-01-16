# frozen_string_literal: true

class AddIndexToRepositoriesName < ActiveRecord::Migration[7.1]
  def change
    add_index :repositories, %i[name user_id], unique: true
  end
end
