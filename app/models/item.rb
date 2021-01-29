class Item < ApplicationRecord
  attachment :image
  belongs_to :genre ,optional: true
  has_many :order_items, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  validates :genre_id, presence: true
  validates :name, presence: true, length: {maximum: 20}
  validates :introduction, presence: true, length: {maximum: 200}
  validates :price, presence: true
end
