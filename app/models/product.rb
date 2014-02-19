class Product < ActiveRecord::Base
  belongs_to :user
  has_many :sales
  attr_accessible :description, :name, :permalink, :price, :file

  has_attached_file :file


# SPINACH check out this validation
  validates_numericality_of :price,
    greater_than: 49,
    message: "must be at least 50 cents"
end
