class ChatMessage < ApplicationRecord
  belongs_to :club
  belongs_to :user

  # Single-level replies
  belongs_to :reply_to, class_name: "ChatMessage", optional: true
  has_many :replies, class_name: "ChatMessage", foreign_key: "reply_to_id", dependent: :nullify

  validates :content, presence: true, length: { maximum: 1000 }
  
  # Profanity filter
  validates :content, profanity: { message: "contains inappropriate language" }
end
