class Post < ApplicationRecord
  belongs_to :user
  has_one :balance, dependent: :destroy
  has_one :fixed_profile, dependent: :destroy
  has_one :explanation, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  validates :month, uniqueness: { scope: :user }
  validates :month, :net_income, :housing, :utilities, :internet,
            :groceries, :daily_necessities, :entertainment, :others,
            presence: true
  validates :net_income, :housing, :utilities, :internet,
            :groceries, :daily_necessities, :entertainment, :others,
            numericality: { only_integer: true }

  def chart_items
    { '家賃': housing, '水道光熱費': utilities, '通信費': internet, '食費': groceries,
      '日用品費': daily_necessities, '娯楽費': entertainment, 'その他出費': others, '貯金': balance.amount }
  end

  def expenses
    (housing + utilities + internet + groceries + daily_necessities + entertainment + others)
  end

  def calculate_balance
    expenses
    (net_income - expenses)
  end

  def saving_rate
    (balance.amount.to_f / net_income * 100).round
  end

  def current_savings
    # balance_total: 投稿した収支の年月までの、投稿者の残高の合計
    balance_total = Post.joins(:balance).select('posts.*, balance.amount').where(user_id: user_id).where('month <= ?', month.to_date)&.sum(:amount)
    (user.initial_savings + balance_total)
  end

  def check_target_achievement_when_create
    target.update(completed: true) if fixed_profile.target.present? && fixed_profile.target <= current_savings
  end

  def check_target_achievement_when_update
    target = user.targets&.last
    if fixed_profile.target.present? && fixed_profile.target == target.amount
      if fixed_profile.target <= current_savings && target.completed == false
        target.update(completed: true)
      elsif fixed_profile.target > current_savings && target.completed == true
        target.update(completed: false)
      end
    end
  end
end
