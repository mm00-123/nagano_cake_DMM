class Address < ApplicationRecord
  belongs_to :customer, optional: true

  validates :postal_code, presence: true
  validates :address, presence: true
  validates :receiver, presence: true

end
