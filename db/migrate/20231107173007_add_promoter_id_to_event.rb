class AddPromoterIdToEvent < ActiveRecord::Migration[7.0]
  def change
    add_column :events, :promoter_id, :integer
  end
end
