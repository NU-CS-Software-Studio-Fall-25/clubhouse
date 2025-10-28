class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :google_id, presence: true, uniqueness: true

  has_many :clubs, dependent: :nullify # clubs they created
  has_many :memberships, dependent: :destroy
  has_many :member_clubs, through: :memberships, source: :club


  def self.from_omniauth(auth)
    where(google_id: auth.uid).first_or_create do |user|
      user.name = auth.info.name
      user.email = auth.info.email
      user.avatar_url = auth.info.image
    end
  end

  def self.from_google!(data)
    user = find_or_initialize_by(google_id: data['id'])
    user.name = data['name']
    user.email = data['email']
    user.avatar_url = data['picture']
    user.save!
    user
  end

  def owns?(club)
    club.user_id == self.id
  end

  def member_of?(club)
    member_clubs.exists?(club.id)
  end


end
