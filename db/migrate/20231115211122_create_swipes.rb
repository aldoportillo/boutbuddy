class CreateSwipes < ActiveRecord::Migration[7.0]
  def change
    create_table :swipes do |t|
      t.integer :swiper_id
      t.integer :swiped_id
      t.boolean :like

      t.timestamps
    end
  end
end
