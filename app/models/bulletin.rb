# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image

  belongs_to :creator, class_name: 'User', foreign_key: 'user_id', inverse_of: :bulletins
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true
  validates :image, presence: true,
                    attached: true,
                    content_type: %i[png jpg jpeg],
                    size: { less_than: 5.megabytes }

  aasm whiny_transitions: false do
    state :on_moderate, initial: true
    state :published, :archived, :rejected

    event :publish do
      transitions from: :on_moderate, to: :published
    end

    event :reject do
      transitions from: :on_moderate, to: :rejected
    end

    event :archive do
      transitions from: %i[on_moderate published], to: :archived
    end
  end
end
