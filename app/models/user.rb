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

# User is a model that represents a user.
class User < ApplicationRecord
  # Include default devise modules for authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Validation for username
  validates :username, presence: true, uniqueness: true

  # Callbacks
  before_save :assign_weight_class
  before_save :assign_username
  after_create :generate_initial_swipes

  # Enum for role
  enum role: {fighter: "fighter", promoter: "promoter", fan: "fan"}

  # Associations for all users
  belongs_to :weight_class, optional: true

  # Associations for fighters
  has_many :participations
  has_many :bouts, through: :participations
  has_many :events, -> { distinct }, through: :bouts
  has_many :results, class_name: :Result, foreign_key: :winner_id
  has_many :win_bys, through: :results
  has_many :given_swipes, class_name: 'Swipe', foreign_key: 'swiper_id'
  has_many :received_swipes, class_name: 'Swipe', foreign_key: 'swiped_id'

  # Associations for promoters
  has_many :own_events, class_name: "Event", foreign_key: "promoter_id"
  has_many :own_venues, class_name: "Venue", foreign_key: "promoter_id"

  # Class methods
  def self.ransackable_attributes(auth_object = nil)
    ["username"]
  end

  # Instance methods
  def admin?
    self.admin
  end

  def users_not_swiped_on
    User.where.not(id: self.id)
        .where.not(id: swiped_user_ids)
        .where(role: "fighter")
        .where(weight_class_id: self.weight_class_id)
  end

  private
  
  # Returns the bouts that are unmatched in the user's weight class
  def stack
    return self.weight_class.unmatched_bouts
  end

  # Assigns the user to a weight class based on their weight
  def assign_weight_class
    self.weight_class = WeightClass.where('min <= :weight AND max >= :weight', weight: self.weight).first
  end

  # Assigns a username to the user based on their first and last name
  def assign_username
    self.username = "#{self.first_name}-#{self.last_name}"
  end

  # Returns the IDs of the users that the current user has swiped on
  def swiped_user_ids
    given_swipes.select(:swiped_id)
  end

  # Generates initial swipes for the user when they are created
  # User recieves a randomized right swipe from the users in the same weight class
  def generate_initial_swipes
    potential_swipers = User.where(weight_class: self.weight_class)
                            .where.not(id: self.id)
    
    potential_swipers.each do |fighter|
      if rand < 0.2
        Swipe.create!(swiper: fighter, swiped: self, like: true)
      end
    end
  end
end
