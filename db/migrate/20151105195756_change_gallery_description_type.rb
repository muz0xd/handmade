class ChangeGalleryDescriptionType < ActiveRecord::Migration
  def change
    change_table :galleries do |t|
      t.change :description, :text
    end
  end
end
