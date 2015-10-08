class Attachment::ImageController < ApplicationController

  before_action :authorize, only: [:edit]

  def original
    attach = ImageAttachment.find(params[:fid])
    if attach.nil?
      redirect_to root_url
    else
      send_file attach.image.path,
        disposition: 'inline',
        type: attach.image_content_type
    end
  end

  def preview
    attach = ImageAttachment.find(params[:fid])
    if attach.nil?
      redirect_to root_url
    else
      send_file attach.image.path(:thumbnail),
        disposition: 'inline',
        type: attach.image_content_type
    end
  end

  def edit
    @image = ImageAttachment.find(params[:fid])
  end

  def update
    attach = ImageAttachment.find(params[:fid])
    if update_params[:image].present?
      attach.image = nil
      attach.save
    else
      update_params.delete(:image)
    end
    attach.update_attributes(update_params)
    attach.image.reprocess!
    redirect_to gallery_path(attach.imagable)
  end

  private

  def authorize
    redirect_to new_admin_session_path unless admin_signed_in?
  end

  def update_params
    params.require(:image_attachment).permit!
  end
end
