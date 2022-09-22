class Gender < ActiveHash::Base
  include ActiveHash::Associations
  has_many :profiles

  self.data = [
    { id: 1, name: '女性' },
    { id: 2, name: '男性' },
    { id: 3, name: 'その他' }
  ]
end
