class Introduction < ApplicationRecord
  belongs_to :user

  validates :title1, :text1, presence: true
  validates :title1, :title2, length: { maximum: 40 }
  validates :text1, :text2, length: { maximum: 250 }
end
