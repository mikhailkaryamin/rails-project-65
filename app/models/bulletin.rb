# frozen_string_literal: true

class Bulletin < ApplicationRecord
  include AASM

  has_one_attached :image do |attached|
    attached.variant :for_form, resize_to_limit: [nil, 100]
  end

  belongs_to :user, counter_cache: :bulletins_count
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true
  validates :image,
            attached: true,
            content_type: {
              in: ['image/jpeg', 'image/jpg', 'image/png'],
              size: { less_than: 5.megabytes }
            }

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
