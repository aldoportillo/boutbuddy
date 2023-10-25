class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :title
      t.datetime :time
      t.integer :price
      t.string :bio
      t.integer :venue_id

      t.timestamps
    end
  end
end
