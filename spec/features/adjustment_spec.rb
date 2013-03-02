require 'spec_helper'

MARGIN = 5

describe "The adjustment page", js: true do
  before do
#     visit adjustments_url
    visit '/adjustments'
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
        page.should have_field 'adjustment[delta]'
      end

      it "shows the updated quantity in a callout" do
        page.should have_content '-5'
      end
    end

    context "and entering a number with a lb unit" do
      before do
        fill_in 'adjustment[delta]', with: "2 lb"
        click_on 'Save'
      end

      it "decreases the quantity by the gram conversion" do
        item.quantity.should be_within(MARGIN).of(-907)
      end

      it "shows the adjustment form again" do
        page.should have_field 'adjustment[delta]'
      end

      it "shows the updated quantity in a callout" do
        page.should have_content '-2'
      end
    end
  end

  context "when chosing 'increment' for an item" do
    let (:item) { FactoryGirl.create(:item) }

    before do
      select 'Increment', from: 'Action'
      fill_in 'adjustment[name]', with: item.name
    end

    context "and entering a number" do
      before do
        fill_in 'adjustment[delta]', with: 3
        click_on 'Save'
      end

      it "increases the quantity by that number" do
        item.quantity.should eq 3
      end

      it "shows the adjustment form again" do
        page.should have_field 'adjustment[delta]'
      end

      it "shows the updated quantity in a callout" do
        page.should have_content '3'
      end
    end
  end

  context "when chosing 'set' for an item" do
    let (:item) { FactoryGirl.create(:item) }

    before do
      item.adjustments << Adjustment.create(item: item, delta: 8)
      select 'Set', from: 'Action'
      fill_in 'adjustment[name]', with: item.name
    end

    context "and entering a number" do
      before do
        fill_in 'adjustment[delta]', with: 2
        click_on 'Save'
      end

      it "resets the quantity to that number" do
        item.quantity.should eq 2
      end

      it "shows the adjustment form again" do
        page.should have_field 'adjustment[delta]'
      end

      it "shows the updated quantity in a callout" do
        page.should have_content '2'
      end
    end
  end

  context "when typing the partial name of an item" do
    let (:item) { FactoryGirl.create(:item, name: 'Foo Bar Baz Item') }

    before do
      # Note: requires Javascript
#       page.driver.render "screenshot.png", full: true
      # Note: this may not work as intended because the field is hidden and then created by select2
      # see:
      # http://stackoverflow.com/questions/12771436/how-to-test-a-select2-element-with-capybara-dsl
      fill_in 'adjustment[name]', with: item.name.slice(0,3).downcase
    end

    it "shows the full name of the item" do
      page.should have_content item.name
    end
  end
end
