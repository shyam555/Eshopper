class Banner < ActiveRecord::Base
  mount_uploader :picture, PictureUploader
  has_many :pictures, as: :imageable
end
