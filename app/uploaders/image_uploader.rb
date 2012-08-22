# encoding: utf-8
require 'carrierwave/processing/mini_magick' 
class ImageUploader < CarrierWave::Uploader::Base
  
  def cache_dir
    "#{Rails.root}/tmp/uploads"
  end

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Include the Sprockets helpers for Rails 3.1+ asset pipeline compatibility:
  # include Sprockets::Helpers::RailsHelper
  # include Sprockets::Helpers::IsolatedHelper

  # Choose what kind of storage to use for this uploader:
  storage :fog
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "#{model.class.to_s.underscore}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  def resize_to_fit(width, height)
    manipulate! do |img|
      if img[:width] > 700
        img.resize "#{width}x#{height}"
        img = yield(img) if block_given?
        img
      end
    end
  end

  # Create different versions of your uploaded files:
  version :thumb, :if => :review? do
    process :resize_to_fit => [30, 30]
  end
  
  def review?(picture)
    model.class.to_s == "Review"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_white_list
    %w(jpg jpeg gif png tiff)
   end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
   def filename
     if original_filename
       @name ||= Digest::MD5.hexdigest(original_filename)+(Time.now.to_s.gsub(" ", "").gsub(":", "").gsub("+", ""))
       "#{@name}.#{file.extension}"
     end
   end

end
