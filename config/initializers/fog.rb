CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       # required
    :aws_access_key_id      => ENV['AMAZON_ACCESS_KEY_ID'],       # copied off the aws site
    :aws_secret_access_key  => ENV['AMAZON_SECRET_ACCESS_KEY'],       # 
  }

  config.fog_directory  = 'volunteervoice_uncropped'                     # required
end