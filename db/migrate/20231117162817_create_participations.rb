class CreateParticipations < ActiveRecord::Migration[7.0]
  def change
    create_table :participations do |t|
      t.integer :user_id
      t.integer :bout_id
      t.string :corner

      t.timestamps
    end
  end
end
