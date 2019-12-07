require 'spec_helper'

RSpec.describe Spree::Product, type: :model do
  context "wholesale products" do

    let(:variant) { create(:wholesale_variant) }
    let(:product) { variant.product }

    it { is_expected.to respond_to(:wholesale_price) }

    it 'should be wholesaleble' do
      product.master = variant
      expect(product.is_wholesaleable?).to be true
    end

  end
end
