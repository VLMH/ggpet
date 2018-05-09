class Adoption < ApplicationRecord
  belongs_to :customer
  belongs_to :pet

  STATUS_OK = 1
end
