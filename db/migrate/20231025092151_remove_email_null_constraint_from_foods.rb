class RemoveEmailNullConstraintFromFoods < ActiveRecord::Migration[6.1]
  def change
    change_column_null :foods, :expiration_date, true
    change_column_null :foods, :jan_code, true
  end
end
