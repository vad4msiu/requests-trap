class Trap < ActiveRecord::Base
  has_many :requests, dependent: :destroy, inverse_of: :trap
end
