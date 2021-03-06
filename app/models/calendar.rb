class Calendar < ActiveRecord::Base

validates :user_id, presence: true
validates :title, presence: true


belongs_to :user
has_many :events, dependent: :destroy
has_many :users
has_many :comments, dependent: :destroy
has_many :calendar_accesses, dependent: :destroy
has_many :activities, through: :events

mount_uploader :image, ImageUploader
end
