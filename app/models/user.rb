class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :targets

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates_format_of :password, { with: PASSWORD_REGEX, messege: "is invalid. Include both letters and numbers" }

  validates :nickname, presence: true
  validates :initial_savings, presence: true
end
