class Item < ActiveRecord::Base
  has_many :adjustments
  attr_accessible :aliases, :name, :weight

  def quantity
    adjustments.sum(&:delta)
  end
end
