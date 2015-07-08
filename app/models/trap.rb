class Trap < ActiveRecord::Base
  self.primary_key = 'name'

  has_many :requests, dependent: :destroy, inverse_of: :trap

  validates :name, presence: true, uniqueness: true
end
