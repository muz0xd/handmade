class CreateImageAttachments < ActiveRecord::Migration
  def change
    create_table :image_attachments do |t|
      t.references :imagable, polymorphic: true, index: true
      t.attachment :image
      t.string :description

      t.timestamps null: false
    end
  end
end
