class Household < ActiveHash::Base
  include ActiveHash::Associations
  has_many :profiles

  self.data = [
    { id: 1, name: '実家暮らし' },
    { id: 2, name: '一人暮らし' },
    { id: 3, name: '二人暮らし' },
    { id: 4, name: '三人世帯' },
    { id: 5, name: '四人世帯' },
    { id: 6, name: '五人世帯' },
    { id: 7, name: 'その他' }
  ]
end
