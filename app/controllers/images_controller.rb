class ImagesController < ApplicationController
  def create
    image = Image4ye.upload(params[:image])
    render json: {url: image.url}
  end
end
