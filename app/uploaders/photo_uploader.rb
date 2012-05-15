class PhotoUploader < Progstr::Filer::Uploader
  storage :fog
  
  def store_dir
    'volunteervoice_uncropped'
  end
end