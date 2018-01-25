# Copyright (c) 2015, @sudharti(Sudharsanan Muralidharan)
# Socify is an Open source Social network written in Ruby on Rails This file is licensed
# under GNU GPL v2 or later. See the LICENSE.

require_dependency "carrierwave"

module Socify
  class AvatarUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    storage :fog if Rails.env.production?

    # Choose what kind of storage to use for this uploader:
    storage :file if Rails.env.development?
    storage :fog if Rails.env.production?

    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end

    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url
    #   # For Rails 3.1+ asset pipeline compatibility:
    #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    #
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end

    # Process files as they are uploaded:
    process :thumb => [332.5]

    def thumb(width)
      manipulate! do |img|
        img.thumbnail(width)
      end
    end

    # Create different versions of your uploaded files:
    # version :thumb do
    #   process :resize_to_fit => [50, 50]
    # end

    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_white_list
      %w(jpg jpeg gif png)
    end

    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end
  end
end
