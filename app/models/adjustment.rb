class Adjustment < ActiveRecord::Base
  belongs_to :item
  attr_accessible :delta, :reset
end
