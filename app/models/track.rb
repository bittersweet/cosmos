class Track < ActiveRecord::Base
  mount_uploader :file, AudioUploader
end
