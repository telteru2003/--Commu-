# frozen_string_literal: true

class CreateFoods < ActiveRecord::Migration[6.1]
  def change
    create_table :foods do |t|
      t.integer :user_id, null: false
      t.integer :genre_id
      t.integer :place_id
      t.string :name, null: false
      t.date :expiration_date, null: false
      t.integer :jan_code
      t.integer :consume_status, default: 0, null: false

      t.timestamps null: false
    end
  end
end
