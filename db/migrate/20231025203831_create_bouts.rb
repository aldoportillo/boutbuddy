class CreateBouts < ActiveRecord::Migration[7.0]
  def change
    create_table :bouts do |t|
      t.integer :event_id
      t.integer :weight_class_id

      t.timestamps
    end
  end
end
