class Explanation < ApplicationRecord
  belongs_to :post

  validates :text, presence: true
end
