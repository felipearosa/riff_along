class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :lists
  has_many :catalogs, through: :lists
  has_many :videos, through: :catalogs
  has_many :solos, through: :videos
  has_many :podia
  has_many :achievements, through: :podia

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true
 
end
