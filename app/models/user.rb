class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validate :birthdate_must_be_past

  private

  def birthdate_must_be_past
    if birthdate && birthdate > Time.zone.now
      errors.add(:birthdate, "must be past")
    end
  end
end
