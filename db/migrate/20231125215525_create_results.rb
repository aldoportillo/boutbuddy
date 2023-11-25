class CreateResults < ActiveRecord::Migration[7.0]
  def change
    create_table :results do |t|
      t.references :bout, null: false, foreign_key: true
      t.integer :winner_id
      t.string :win_by

      t.timestamps
    end
  end
end
