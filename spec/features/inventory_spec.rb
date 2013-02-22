require 'spec_helper'

describe "The inventory page" do
  it "shows a drop-down for the type of update"

  it "shows an auto-complete field for the item name"

  it "shows a field for the update quantity"

  context "when chosing 'decrement' for an item" do
    context "and entering a number" do
      it "decreases the quantity by that number"

      it "shows the inventory form again"

      it "shows the updated quantity in a callout"
    end
  end
end
