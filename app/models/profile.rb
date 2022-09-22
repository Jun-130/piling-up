class Profile < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :user
  belongs_to :age
  belongs_to :gender
  belongs_to :household
  belongs_to :annual_income
  belongs_to :prefecture

  with_options presence: true do
    validates :age
    validates :gender
    validates :household
    validates :annual_income
    validates :prefecture
    validates :monthly_target
  end
end
