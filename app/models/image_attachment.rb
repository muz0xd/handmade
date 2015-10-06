class ImageAttachment < ActiveRecord::Base

  ATTACHED_FILESIZE_LIMIT = 10.megabytes

  ATTACHED_FILETYPES = %w(
     image/jpeg
     image/jpg
     image/png
     image/gif
  )

  belongs_to :imagable, polymorphic: true

  has_attached_file :image,
    styles: {thumbnail: ["500x500", :jpg]},
    url: File.join( Rails.application.config.attachments_root,
                   '/:class/:attachment/:id_partition/:style/:filename'),
    path: File.join( Rails.application.config.attachments_root,
                   '/:class/:attachment/:id_partition/:style/:filename')

  validates_attachment :image, presence: true,
                       content_type: { content_type: ATTACHED_FILETYPES },
                       size: { in: 0..ATTACHED_FILESIZE_LIMIT }

  def self.multiple_create attachments = [], gallery
    if attachments.present?
      attachments.each do |attachment|
        image_attach = self.create({image: attachment})
        image_attach.update_attribute(:imagable, gallery)
      end
    end
  end
end
