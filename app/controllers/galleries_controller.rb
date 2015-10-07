class GalleriesController < ApplicationController

  before_action :authorize, except: [:index, :show]

  def index
    @galleries = Gallery.all
  end

  def new
    @gallery = Gallery.new
  end

  def create
    gallery = Gallery.create gallery_params
    ImageAttachment.multiple_create images_params[:images], gallery
    redirect_to galleries_path
  end

  def show
    @gallery = Gallery.find(params[:id])
  end

  private

  def authorize
    redirect_to new_admin_session_path unless admin_signed_in?
  end

  def gallery_params
    g_params = params[:gallery].reject { |k,v|
      k == "images"
    }
    g_params.permit!
  end

  def images_params
    i_params = params[:gallery].select {|k,v|
      k == 'images'
    }
    i_params.permit!
  end
end
