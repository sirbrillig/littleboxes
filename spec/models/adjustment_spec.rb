require 'spec_helper'

MARGIN = 10

shared_examples_for "an item quantity of 0.8" do |value|
  let(:item) { FactoryGirl.create(:item) }

  describe "#convert(#{value.inspect})" do
    context "when the item weight is 0.4 kg" do
      before { item.weight = 400 }

      it "should set the item quantity to 800" do
        item.adjustments << Adjustment.create(item: item).convert(value)
        item.quantity.should be_within(MARGIN).of(800)
      end
    end
  end
end

shared_examples_for "a delta of 0.8" do |value|
  let(:item) { FactoryGirl.create(:item) }

  describe "#convert(#{value.inspect})" do
    context "when the item weight is 0.4 kg" do
      before { item.weight = 400 }

      it "should set the delta to 800" do
        adj = Adjustment.create(item: item).convert(value)
        adj.delta.should be_within(MARGIN).of(800)
      end
    end
  end
end

describe Adjustment do

  context "without an item" do
    describe "#convert(800)" do
      it "should set the delta to 800" do
        adj = Adjustment.create().convert(800)
        adj.delta.should be_within(MARGIN).of(800)
      end
    end
  end

  it_should_behave_like "a delta of 0.8", '800 g'

  it_should_behave_like "a delta of 0.8", '.8kg'

  it_should_behave_like "a delta of 0.8", '0.8kg'

  it_should_behave_like "a delta of 0.8", '0.8 kg'

  it_should_behave_like "an item quantity of 0.8", 2

  it_should_behave_like "an item quantity of 0.8", '2'

  it_should_behave_like "a delta of 0.8", '1.7660 lb'

  it_should_behave_like "a delta of 0.8", '28.2192 oz'

  it_should_behave_like "a delta of 0.8", '1 lb 12.2192 oz'
end
