# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  height                 :integer
#  last_name              :string
#  photo                  :string
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

  has_many :participations
  has_many :bouts, through: :participations
  has_many :events, -> { distinct }, through: :bouts
  
  #Here we have a direct relationship to Results
  #We can Scope this to bouts as well if we need to later but maybe not since we only want stats
  #If we do, we will need to update name wins everywhere before we do.
  has_many :results, class_name: :Result, foreign_key: :winner_id
  has_many :win_bys, through: :results



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

  def self.ransackable_attributes(auth_object = nil)
    ["username"]
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
