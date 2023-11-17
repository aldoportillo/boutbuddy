# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  height                 :integer
#  last_name              :string
#  photo_url              :string
#  reach                  :integer
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string
#  username               :string
#  weight                 :integer
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  weight_class_id        :integer
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :username, presence: true, uniqueness: true
  before_save :assign_weight_class

  #FOR FIGHTER

  belongs_to :weight_class, optional: true

  ##START Ian's table suggestion will get rid of this!

  has_many :red_corner_bouts, class_name: 'Bout', foreign_key: 'red_corner_id'
  has_many :blue_corner_bouts, class_name: 'Bout', foreign_key: 'blue_corner_id'

  def bouts
    Bout.where("red_corner_id = :id OR blue_corner_id = :id", id: self.id)
  end


  has_many :red_corner_events, through: :red_corner_bouts, source: :event
  has_many :blue_corner_events, through: :blue_corner_bouts, source: :event

  def events
    (red_corner_events + blue_corner_events).uniq
  end


  ##END

  # Swipes relationships
  has_many :given_swipes, class_name: 'Swipe', foreign_key: 'swiper_id'
  has_many :received_swipes, class_name: 'Swipe', foreign_key: 'swiped_id'

  #FOR PROMOTER

  has_many :own_events, class_name: "Event", foreign_key: "promoter_id"
  has_many :own_venues, class_name: "Venue", foreign_key: "promoter_id"
  
  enum role: {admin: "admin", fighter: "fighter", promoter: "promoter", undetermined: "undetermined"}


  def users_not_swiped_on
    User.where.not(id: self.id)
        .where.not(id: swiped_user_ids)
        .where(role: "fighter")
        .where(weight_class_id: self.weight_class_id)
  end


  private
  
  def stack
    return self.weight_class.unmatched_bouts
  end

  def assign_weight_class
    self.weight_class = WeightClass.where('min <= :weight AND max >= :weight', weight: self.weight).first
  end

  def swiped_user_ids
    given_swipes.select(:swiped_id)
  end
end
