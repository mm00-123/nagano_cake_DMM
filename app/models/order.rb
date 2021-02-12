class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_items, dependent: :destroy

  has_many :items, :through => :order_items

  enum settlement: [:クレジットカード, :銀行振込]
  enum order_status: [ :入金待ち, :入金確認, :製作中, :発送準備中, :発送済み ]

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :settlement, presence: true

end
