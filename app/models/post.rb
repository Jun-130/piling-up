class Post < ApplicationRecord
  belongs_to :user
  has_one :balance, dependent: :destroy
  has_one :fixed_profile, dependent: :destroy

  validates :month, :net_income, :housing, :utilities, :internet,
            :groceries, :daily_necessities, :entertainment, :others,
            presence: true 
  validates :net_income, :housing, :utilities, :internet,
            :groceries, :daily_necessities, :entertainment, :others,
            numericality: {only_integer: true}

  def chart_items
    ({'家賃': self.housing, '水道光熱費': self.utilities, '通信費': self.internet, '食費': self.groceries, '日用品費': self.daily_necessities, '娯楽費': self.entertainment, 'その他出費': self.others, '貯金': self.balance.amount})
  end

  def expenses
    (self.housing + self.utilities + self.internet + self.groceries + self.daily_necessities + self.entertainment + self.others)
  end

  def calculate_balance
    self.expenses
    return (self.net_income - expenses)
  end

  def saving_rate
    (self.balance.amount.to_f / self.net_income.to_f * 100).round
  end

  def current_savings
    # 投稿した収支の年月までの、投稿者の残高の合計
    balance_total = Post.joins(:balance).select('posts.*, balance.amount').where(user_id: self.user_id).where("month <= ?", self.month.to_date)&.sum(:amount)
    return (self.user.initial_savings + balance_total)
  end

  def check_target_achievement
    target = self.user.targets&.last
    if self.fixed_profile.target.present? && self.fixed_profile.target <= self.current_savings && target.status == 0
      target.update(status: 1)
    elsif self.fixed_profile.target.present? && self.fixed_profile.target > self.current_savings && target.status == 1
      target.update(status: 0)
    end
  end
end
