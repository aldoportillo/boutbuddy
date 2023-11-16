class AddWeightClassToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :weight_class_id, :integer
  end
end
