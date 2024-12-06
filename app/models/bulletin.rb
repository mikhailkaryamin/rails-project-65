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

  def self.ransackable_attributes(_auth_object = nil)
    %w[category_id created_at description id id_value title updated_at user_id]
  end

  aasm column: :state, whiny_transitions: false do
    state :draft, initial: true
    state :under_moderation, :published, :archived, :rejected

    event :to_moderate do
      transitions from: :draft, to: :under_moderation
    end

    event :publish do
      transitions from: :under_moderation, to: :published
    end

    event :reject do
      transitions from: :under_moderation, to: :rejected
    end

    event :archive do
      transitions from: %i[draft under_moderation published rejected], to: :archived
    end
  end
end
