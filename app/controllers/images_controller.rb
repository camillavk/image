class ImagesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def upload
    uploader = ImageUploader.new
    File.open(image_path_params) { |f| uploader.store!(f) }
    render json: { image_name: "#{uploader.identifier}" }
  end

  def retrieve
    uploader = ImageUploader.new
    uploader.retrieve_from_store!(image_name_params)

    image = uploader.file
    render json: image
  end

  private

  def image_path_params
    params.require(:image_path)
  end

  def image_name_params
    params.require(:image_name)
  end
end
