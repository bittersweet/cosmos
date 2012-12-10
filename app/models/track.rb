class Track < ActiveRecord::Base
  mount_uploader :file, AudioUploader

  belongs_to :user

  attr_accessible :title, :file

  validates_presence_of :title, :file

  scope :ordered, order('id DESC')
end
