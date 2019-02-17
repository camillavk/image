class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :fog
  storage :file if Rails.env.test?

  def filename
    SecureRandom.hex + '-' + super
  end
end
