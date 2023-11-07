class AddPromoterIdToVenue < ActiveRecord::Migration[7.0]
  def change
    add_column :venues, :promoter_id, :integer
  end
end
