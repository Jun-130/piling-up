class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_one :introduction, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :targets, dependent: :destroy

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates_format_of :password, { with: PASSWORD_REGEX, messege: "is invalid. Include both letters and numbers" }

  validates :nickname, presence: true
  validates :initial_savings, presence: true

  def current_savings
    # balance_total: userのこれまでの残高の合計
    balance_total = Post.joins(:balance).select('posts.*, balance.amount').where(user_id: self.id)&.sum(:amount)
    return (self.initial_savings + balance_total)
  end

  def check_target_achievement
    target = self.targets&.last
    if target.present? && target.amount <= self.current_savings && target.completed == false
      target.update(status: true)
    elsif target.present? && target.amount > self.current_savings && target.completed == true
      target.update(status: false)
    end
  end
end

