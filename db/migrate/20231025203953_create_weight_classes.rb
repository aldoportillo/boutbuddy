class CreateWeightClasses < ActiveRecord::Migration[7.0]
  def change
    create_table :weight_classes do |t|
      t.string :name
      t.float :min
      t.float :max

      t.timestamps
    end
  end
end
