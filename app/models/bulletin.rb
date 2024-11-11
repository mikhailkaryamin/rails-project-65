# frozen_string_literal: true

class Bulletin < ApplicationRecord
  has_one_attached :image

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id', inverse_of: :bulletins
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true
  validates :category, presence: true
  validates :image, presence: true,
                    attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }
end
