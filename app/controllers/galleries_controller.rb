class GalleriesController < ApplicationController
  def index
    render :index, layout: false
  end

  def new
    @gallery = Gallery.new
  end

  def create


    gallery = Gallery.create gallery_params

    ImageAttachment.multiple_create images_params[:images], gallery

    render :index
  end

  private

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
