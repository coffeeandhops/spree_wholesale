require 'spec_helper'

RSpec.describe Spree::Order, type: :model do
  context "wholesale products" do
    let(:wholesaler) { create(:wholesaler) }
    let(:wholesale_order) { create(:order, user: wholesaler.user, wholesale: true) }
    let(:normal_order) { create(:order) }
    let(:variant) { create(:wholesale_variant) }
    let(:variant2) { build(:wholesale_variant) }

    it { is_expected.to respond_to(:wholesale) }

    it 'should be wholesale' do
      expect(wholesale_order.is_wholesale?).to be true
    end

    it 'should convert to wholesale' do
      expect(normal_order.is_wholesale?).to be false
      expect(normal_order.to_wholesale!).to be false
      expect(normal_order.is_wholesale?).to be false

      normal_order.user.wholesaler = wholesaler
      expect(normal_order.to_wholesale!).to be true
      expect(normal_order.is_wholesale?).to be true
    end

    it 'should get regular price' do
      expect(normal_order.item_total).to eq(0)
      normal_order.add_variant(variant)
      normal_order.update_with_updater!
      expect(normal_order.item_total).to eq(19.99)
    end

    it 'should get wholesale price' do
      expect(wholesale_order.item_total).to eq(0)
      wholesale_order.add_variant(variant)
      wholesale_order.update_with_updater!
      expect(wholesale_order.item_total).to eq(9.5)
    end

    it 'should not require payment if wholesale with net terms' do
      wholesaler.terms = "Net30"
      wholesaler.save!
      wholesale_order.add_variant(variant)
      expect(wholesale_order.payment_required?).to be false
    end

    it 'require payment if not wholesale with net terms' do
      wholesale_order.add_variant(variant)
      expect(wholesale_order.payment_required?).to be true

      order1 = create(:order, user: wholesaler.user, wholesale: false)
      order1.add_variant(create(:wholesale_variant))
      expect(order1.payment_required?).to be true
  
      order2 = create(:order)
      order2.add_variant(create(:wholesale_variant))
      expect(order2.payment_required?).to be true
    end

  end
end
