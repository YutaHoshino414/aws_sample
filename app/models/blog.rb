class Blog < ApplicationRecord
  belongs_to :category
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many_attached :images
end
