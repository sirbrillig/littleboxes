class Item < ActiveRecord::Base
  has_many :adjustments
  attr_accessible :aliases, :name, :weight

  def quantity
    total = adjustments.sum(&:delta)
    total *= weight if weight
    total
  end
end
