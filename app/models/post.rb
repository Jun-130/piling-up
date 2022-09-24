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

  def pie_chart
    {'家賃': self.housing, '水道光熱費': self.utilities, '通信費': self.internet, '食費': self.groceries, '日用品費': self.daily_necessities, '娯楽費': self.entertainment, 'その他出費': self.others, '貯金': self.balance.amount}
  end

  def calculate_expenses
    expenses = (
                + self.housing
                + self.utilities
                + self.internet
                + self.groceries
                + self.daily_necessities
                + self.entertainment
                + self.others
              )
    return expenses
  end

  def calculate_balance
    expenses = self.calculate_expenses
    balance = self.net_income - expenses
    return balance
  end
end
