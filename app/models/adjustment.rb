class Adjustment < ActiveRecord::Base
  belongs_to :item
  attr_accessible :delta, :reset, :item

  # 
  # Takes a value, which can be a string or a number and tries many ways to
  # convert it to a (g) delta value, using the `item` object associated with
  # this Adjustment, if one exists. Returns the adjustment.
  #
  # Note that if the value is has no units and there is an associated `item`
  # with a weight, the value is assumed to be a quantity of items. If the value
  # has no units and there is no associated item or the associated item has no
  # weight, the value is assumed to be in grams.
  # 
  def convert(value)
    delta_value = nil

    if value.is_a? String
      if value =~ /^\s*([\d\.]+)\s*(\w{1,2})\s*(([\d\.]+)\s*(\w{1,2}))?\s*$/ # number and units
        number, units = $1.to_f, $2.downcase
        sub_number, sub_units = $4.to_f, $5.downcase if $3
        raise "Could not convert string '#{value}'" unless number and units
        delta_value = convert_units(number, units)
        raise "Unknown units in '#{value}'" unless delta_value
        delta_value += convert_units(sub_number, sub_units) if sub_number and sub_units
      elsif value =~ /^[\d.]+$/
        delta_value = value.to_i
      else
        raise "Unknown string '#{value}'"
      end
    else
      delta_value = value.to_i
    end

    self.delta = delta_value

    self
  end

  private
  def convert_units(number, units)
    case units
    when 'g'
      number.to_i
    when 'kg'
      number * 1000
    when 'lb'
      number * 453
    when 'oz'
      number * 28
    else
      nil
    end
  end
end
