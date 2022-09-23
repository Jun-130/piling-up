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
