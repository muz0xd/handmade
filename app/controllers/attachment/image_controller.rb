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
    image = ImageAttachment.find(params[:fid])
    image.update_attributes(update_params)
    redirect_to attachment_image_preview_path
  end

  private

  def authorize
    redirect_to new_admin_session_path unless admin_signed_in?
  end

  def update_params
    params.require(:image_attachment).permit!
  end
end
