class Track < ActiveRecord::Base
  mount_uploader :file, AudioUploader

  belongs_to :user

  attr_accessible :title, :file

  validates_presence_of :title, :file

  before_save :set_file_size

  scope :ordered, order('id DESC')

  private

  def set_file_size
    return if !file_changed?

    self.file_size = file.file.size
  end
end
