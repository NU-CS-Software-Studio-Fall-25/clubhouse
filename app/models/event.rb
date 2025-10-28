class Event < ApplicationRecord
  belongs_to :club
  belongs_to :user
  validates :name, presence: true
  validates :date, presence: true

  def event_parmas
    params.require(:event).permit(:name, :date, :location, :description)
  end


end
