class Gallery < ActiveRecord::Base
  has_many :image_attachments, as: :imagable
end
