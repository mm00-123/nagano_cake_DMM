class Address < ApplicationRecord
  belongs_to :customer, optional: true

  with_options presence: true do |d|
        d.validates :customer_id
        d.validates :address
        d.validates :postal_code
        d.validates :name
    end

end
