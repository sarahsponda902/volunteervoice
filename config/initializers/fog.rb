# Be sure to restart your server when you modify this file.

# Configuration for file uploads with fog, carrierwave, amazon s3
CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',       
    :aws_access_key_id      => ENV['AMAZON_ACCESS_KEY_ID'],      
    :aws_secret_access_key  => ENV['AMAZON_SECRET_ACCESS_KEY'],      
    :region => 'us-east-1',
    :persistent => false # This is required to prevent write timeouts from PUT requests to S3
  }
  config.fog_directory  = 'volunteervoiceuploads'                     
end