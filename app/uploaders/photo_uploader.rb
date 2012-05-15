class PhotoUploader < CarrierWave::Uploader::Base
  storage :fog
  
  def store_dir
    'volunteervoice_uncropped'
  end
end