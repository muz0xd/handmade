class Attachment::ImageController < ApplicationController

  before_action :authorize, only: [:edit, :download, :destroy]
  protect_from_forgery except: :download

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

  def download
    attach = ImageAttachment.create image: params[:file]
    render json: {link: attachment_image_path(attach)}, status: :ok
  end

  def destroy
    id = params["src"][/\d+\z/].to_i
    gallery_id = params["gallery_id"]

    attach = ImageAttachment.find(id)
    attach.image = nil
    attach.save
    attach.destroy

    respond_to do |format|
      format.json { render json: {}, status: :ok } if request.xhr?
      format.html { redirect_to gallery_path(gallery_id) }
    end
  end

  private

  def authorize
    redirect_to new_admin_session_path unless admin_signed_in?
  end

  def update_params
    params.require(:image_attachment).permit!
  end

end
