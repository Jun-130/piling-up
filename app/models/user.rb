class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_one :profile, dependent: :destroy
  has_one :introduction, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :targets, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :follower, class_name: 'Follow', foreign_key: 'follower_id', dependent: :destroy
  has_many :followee, class_name: 'Follow', foreign_key: 'followee_id', dependent: :destroy
  has_many :followees, through: :follower, source: :followee # 自分がフォローしている人
  has_many :followers, through: :followee, source: :follower # 自分をフォローしている人

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze

  validates_format_of :password, { with: PASSWORD_REGEX, messege: 'is invalid. Include both letters and numbers' }

  validates :nickname, presence: true
  validates :initial_savings, presence: true

  def current_savings
    # balance_total: userのこれまでの残高の合計
    balance_total = Post.joins(:balance).select('posts.*, balance.amount').where(user_id: id)&.sum(:amount)
    (initial_savings + balance_total)
  end

  def check_target_achievement
    target = targets&.last
    if target.present?
      if target.amount <= current_savings && target.completed == false
        target.update(completed: true)
      elsif target.amount > current_savings && target.completed == true
        target.update(completed: false)
      end
    end
  end

  def like?(post)
    like = likes.find_by(post_id: post.id)
    like.present?
  end

  def follow(other_user)
    follower.find_or_create_by(followee_id: other_user.id) unless self == other_user
  end

  def unfollow(other_user)
    follow = follower.find_by(followee_id: other_user.id)
    follow&.destroy
  end

  def following?(other_user)
    followees.include?(other_user)
  end
end
