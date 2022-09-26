class Target < ApplicationRecord
  belongs_to :user

  with_options presence: true do
    validates :deadline
    validates :amount, numericality: { only_integer: true }
  end
  validates :completed, inclusion: [true, false],
                        uniqueness: { scope: :user, on: :create, message: "未達成の目標があるため、新しい目標は設定できません" }
end
