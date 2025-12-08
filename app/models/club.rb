class Club < ApplicationRecord
    belongs_to :user
    has_many :events, dependent: :destroy
    has_many :memberships, dependent: :destroy
    has_many :members, -> { where(memberships: { status: "approved" }) }, through: :memberships, source: :user
    has_many :pending_memberships, -> { where(status: "pending") }, class_name: "Membership"
    has_many :pending_members, through: :pending_memberships, source: :user
    has_many :chat_messages, dependent: :destroy
    has_one_attached :profile_photo

    validates :name, presence: true
    validates :name, length: { maximum: 50 }
    validates :description, length: { maximum: 300 }, allow_blank: true
    
    # Profanity filters
    validates :name, profanity: { message: "contains inappropriate language" }
    validates :description, profanity: { message: "contains inappropriate language" }, if: -> { description.present? }
end
