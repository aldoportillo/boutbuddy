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

  has_many :registered_bouts, class_name: "Bout", foreign_key: "red_corner_id"
  has_many :accepted_bouts, class_name: "Bout", foreign_key: "blue_corner_id"
  has_many :messages, class_name: "Message", foreign_key: "user_id"
  
  enum role: {admin: "admin", fighter: "fighter", promoter: "promoter", sample:}
  #TODO: Point to weightclass ID on signup

  def weight_class
    return WeightClass.where('min <= :weight AND max >= :weight', weight: self.weight).at(0)
  end

  def stack
    return self.weight_class.unmatched_bouts
  end
end
