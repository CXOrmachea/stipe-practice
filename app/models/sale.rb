class Sale < ActiveRecord::Base
  belongs_to :product
  attr_accessible :email, :guid

  before_create :populate_guid

  private
  def populate_guid
    self.guid = SecureRandom.uuid()
  end
end
