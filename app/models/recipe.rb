class Recipe < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :preparation_time, presence: true, length: { maximum: 50 }
  validates :cooking_time, presence: true, length: { maximum: 50 }
  validates :description, presence: true, length: { maximum: 250 }

  belongs_to :user
  has_many :recipefoods, dependent: :destroy
end
