class Video < ApplicationRecord
  belongs_to :user

  validates :name, presence: true
  validates :url, presence: true

  delegate :name, to: :user, prefix: true
end
