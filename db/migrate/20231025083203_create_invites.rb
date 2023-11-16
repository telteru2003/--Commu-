# frozen_string_literal: true

class CreateInvites < ActiveRecord::Migration[6.1]
  def change
    create_table :invites do |t|
      t.integer :family_id, null: false
      t.string :name, null: false
      t.string :token, null: false

      t.timestamps null: false
    end
  end
end
