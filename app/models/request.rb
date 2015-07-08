class Request < ActiveRecord::Base
  belongs_to :trap

  validates :trap, presence: true

  serialize :headers,      JsonParser
  serialize :query_params, JsonParser
  serialize :cookies,      JsonParser
end
