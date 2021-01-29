class Order < ApplicationRecord
  belongs_to :member
  has_many :order_items, dependent: :destroy

#中間テーブルを介して複数のプロダクトを持つ
  has_many :items, :through => :order_items

  enum payment_method: [:クレジットカード, :銀行振込]
  enum order_status: [ :入金待ち, :入金確認, :製作中, :発送準備中, :発送済み ]

  validates :postal_code, presence: true, format: { with: /\A\d{7}\z/ }
  validates :address, presence: true
  validates :receiver, presence: true
  validates :payment_method, presence: true
  
end
