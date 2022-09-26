class Introduction < ApplicationRecord
  belongs_to :user

  validates :title1, :content1, presence: true
end
