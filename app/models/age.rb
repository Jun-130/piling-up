class Age < ActiveHash::Base
  include ActiveHash::Associations
  has_many :profiles

  self.data = [
    { id: 1, name: '25歳未満' },
    { id: 2, name: '25〜34歳' },
    { id: 3, name: '35〜44歳' },
    { id: 4, name: '45〜54歳' },
    { id: 5, name: '55〜64歳' },
    { id: 6, name: '65歳以上' }
  ]
end
