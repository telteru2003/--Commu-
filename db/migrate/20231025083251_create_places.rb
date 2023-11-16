# frozen_string_literal: true

class CreatePlaces < ActiveRecord::Migration[6.1]
  def change
    create_table :places do |t|
      t.integer :family_id
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
