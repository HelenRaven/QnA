class Award < ApplicationRecord
  belongs_to :question
  belongs_to :user, optional: true

  has_one_attached :image

  validates :title, presence: true
  validates :image, attached: true, content_type: %i[png jpg jpeg]
end
