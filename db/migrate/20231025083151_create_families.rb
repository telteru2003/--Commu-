# frozen_string_literal: true

class CreateFamilies < ActiveRecord::Migration[6.1]
  def change
    create_table :families do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
  end
end
