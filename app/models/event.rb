class Event < ApplicationRecord
  belongs_to :club
  belongs_to :user
  

  attr_accessor :recurring, :end_date, :description

  validates :name, presence: true
  validates :date, presence: true
  validate :recurring_end_after_start, if: -> {recurring == "1" && end_date.present? }

  def event_parmas
    params.require(:event).permit(:name, :date, :location, :description, :club_id, :recurring, :end_date)
  end

  private

  def recurring_end_after_start
    begin
        ed = Date.parse(end_date)
        errors.add(:date, "is rquired") if date.blank?
        errors.add(:end_date, "must be on or after the start date") if ed < date.to_date
    rescue ArgumentError
        errors.add(:end_date, "is not a valid date")
    end
  end
  
  


end
