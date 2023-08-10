class Food < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :measurement_unit, presence: true, length: { maximum: 50 }
  validates :price, numericality: { greater_than: 0, less_than: 100000000 }
  validates :quantity, numericality: { only_integer: true, greater_than_or_equal_to: 1 }

  belongs_to :user
  has_many :dishes, dependent: :destroy
end
