class AnnualIncome < ActiveHash::Base
  include ActiveHash::Associations
  has_many :profiles

  self.data = [
    { id: 1, name: '100万円未満' },
    { id: 2, name: '100万円代' },
    { id: 3, name: '200万円代' },
    { id: 4, name: '300万円代' },
    { id: 5, name: '400万円代' },
    { id: 6, name: '500〜600万円代' },
    { id: 7, name: '700〜800万円代' },
    { id: 8, name: '900〜1000万円代' },
    { id: 9, name: '1100万円以上' }
  ]
end
