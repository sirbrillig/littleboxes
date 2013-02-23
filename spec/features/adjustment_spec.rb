require 'spec_helper'

describe "The adjustment page" do
  before do
    visit adjustments_url
  end

  it "shows a drop-down for the type of update" do
    page.should have_select 'adjustment[action]'
  end

  it "shows an auto-complete field for the item name" do
    page.should have_field 'adjustment[name]'
  end

  it "shows a field for the update quantity" do
    page.should have_field 'adjustment[delta]'
  end

  context "when chosing 'decrement' for an item" do
    let (:item) { FactoryGirl.create(:item) }

    before do
      select 'Decrement', from: 'Action'
      fill_in 'adjustment[name]', with: item.name
    end

    context "and entering a number" do
      before do
        fill_in 'adjustment[delta]', with: 5
        click_on 'Save'
      end

      it "decreases the quantity by that number" do
        item.quantity.should eq -5
      end

      it "shows the adjustment form again" do
        page.should have_field 'delta'
      end

      it "shows the updated quantity in a callout" do
        page.should have_content '-5'
      end
    end
  end
end
