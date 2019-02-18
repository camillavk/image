class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  storage :fog
  storage :file if Rails.env.test?

  version :png do
    process convert: 'png'
    def filename
      super.split('.')[0] + '.png'
    end
  end

  def filename
    unique_hex + '-' + super
  end

  def unique_hex
    SecureRandom.hex
  end
end
