class OrderItem < ApplicationRecord
  belongs_to :item
  belongs_to :order, optional: true

  enum production_status: [ :着手不可, :製作待ち, :製作中 , :製作完了 ]

end
