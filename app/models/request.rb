class Request < ActiveRecord::Base
  belongs_to :trap

  validates :trap, presence: true

  after_create :publish

  serialize :headers,      JsonParser
  serialize :query_params, JsonParser
  serialize :cookies,      JsonParser

  private

  def publish
    PublishService.new(self).perform
  end
end
