class Introduction < ApplicationRecord
  belongs_to :user

  validates :title1, :text1, presence: true
end
