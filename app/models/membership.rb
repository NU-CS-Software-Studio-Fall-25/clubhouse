class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :club
  
  validates :user_id, uniqueness: { scope: :club_id }
  validates :status, presence: true, inclusion: { in: %w[pending approved rejected] }
  
  # Scopes for different membership statuses
  scope :pending, -> { where(status: "pending") }
  scope :approved, -> { where(status: "approved") }
  scope :rejected, -> { where(status: "rejected") }
  
  # Helper methods
  def pending?
    status == "pending"
  end
  
  def approved?
    status == "approved"
  end
  
  def rejected?
    status == "rejected"
  end
end
