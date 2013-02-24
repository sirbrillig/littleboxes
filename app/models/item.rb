class Item < ActiveRecord::Base
  has_many :adjustments
  attr_accessible :aliases, :name, :weight

  def quantity
    total = 0
    adjustments.each do |a|
      if a.reset
        total = a.delta
      else
        total += a.delta
      end
    end
    total *= weight if weight
    total
  end
end
