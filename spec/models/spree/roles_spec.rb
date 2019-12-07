require 'spec_helper'

RSpec.describe Spree::Role, type: :model do
  context "wholesale role" do
    let(:product) { build(:product) }
    it 'should have a wholesale role' do
      role = Spree::Role.find_or_create_by(name: "wholesaler")
      expect(role).not_to be_nil
    end
  end
end
