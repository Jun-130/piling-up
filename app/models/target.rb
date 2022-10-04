class Target < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :deadline
    validates :amount, numericality: { only_integer: true }
  end
  validates :completed, inclusion: [true, false],
                        uniqueness: { scope: :user, on: :create, message: '未達成の目標があるため、新しい目標は設定できません' }

  validate :deadline_must_be_in_the_future
  validate :amount_must_be_more_than_current_savings

  def deadline_must_be_in_the_future
    if deadline.to_date >= Date.new.next_month
      errors.add(:deadline, '来月以降の年月を設定してください')
    end
  end

  def amount_must_be_more_than_current_savings
    if amount <= user.current_savings
      errors.add(:amount, '現在の貯金額より大きい金額を設定してください')
    end
  end
end
