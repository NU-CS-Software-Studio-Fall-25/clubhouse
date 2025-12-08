class ChatMessage < ApplicationRecord
  belongs_to :club
  belongs_to :user

  validates :content, presence: true, length: { maximum: 1000 }
  
  # Profanity filter
  validates :content, profanity: { message: "contains inappropriate language" }
end
