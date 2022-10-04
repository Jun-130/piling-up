class Explanation < ApplicationRecord
  belongs_to :post

  validates :text, presence: true, length: { maximum: 100 }
end
