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

  #FOR FIGHTER
  has_many :bouts
  has_many :events, through: :bouts

  # Swipes relationships
  has_many :given_swipes, class_name: 'Swipe', foreign_key: 'swiper_id'
  has_many :received_swipes, class_name: 'Swipe', foreign_key: 'swiped_id'

  #FOR PROMOTER

  has_many :own_events, foreign_key: "promoter_id"
  has_many :own_venues, foreign_key: "promoter_id"
  
  enum role: {admin: "admin", fighter: "fighter", promoter: "promoter", undetermined: "undetermined"}

  def weight_class
    return WeightClass.where('min <= :weight AND max >= :weight', weight: self.weight).at(0)
  end

  def users_not_swiped_on
    User.where.not(id: self.id)
        .where.not(id: swiped_user_ids)
        .where(role: "fighter")
        #Also filter by weight class
  end

  private
  
  def stack
    return self.weight_class.unmatched_bouts
  end

  def swiped_user_ids
    given_swipes.select(:swiped_id)
  end
end
