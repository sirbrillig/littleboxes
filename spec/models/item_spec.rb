require 'spec_helper'

describe Item do
  let(:item) { FactoryGirl.create(:item) }
  let(:adjustments) { [10, -8, 1, 4, 6, 8] }

  context "with several Adjustments" do
    before do
      adjustments.each { |val| item.adjustments << Adjustment.create(delta: val) }
    end

    describe '#quantity' do
       it("returns the combined deltas") { item.quantity.should eq adjustments.sum }
    end
  end
end
