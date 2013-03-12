require 'spec_helper'

describe "Items" do
  describe "search" do
    let!(:item1) { FactoryGirl.create(:item, weight: 501) }
    let!(:item2) { FactoryGirl.create(:item, name: 'Grapes', aliases: "Uvas", weight: 502) }
    let!(:item3) { FactoryGirl.create(:item, name: 'Banannas', aliases: "Platanos", weight: 503) }

    before do
      visit search_items_path
    end

    context "with a non-existent name" do
      before do
        fill_in 'item[query]', with: 'aljnajfaejkaejdnjand'
        within('.form-search') { click_on 'Search' }
      end

      it "shows no matches" do
        page.should have_content "No matches"
      end
    end

    context "with an existent name" do
      before do
        fill_in 'item[query]', with: item1.name
        within('.form-search') { click_on 'Search' }
      end

      it "shows a match" do
        page.should have_content item1.weight
      end
    end

    context "with part of an existent name" do
      before do
        fill_in 'item[query]', with: item1.name.slice(2, 4)
        within('.form-search') { click_on 'Search' }
      end

      it "shows a match" do
        page.should have_content item1.weight
      end
    end

    context "with an existent alias" do
      before do
        fill_in 'item[query]', with: item2.aliases.slice(1, 4)
        within('.form-search') { click_on 'Search' }
      end

      it "shows a match" do
        page.should have_content item2.weight
      end
    end

  end
end
