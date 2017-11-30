class AddOrderToGalleries < ActiveRecord::Migration
  def change
    add_column :galleries, :order, :text
  end
end
