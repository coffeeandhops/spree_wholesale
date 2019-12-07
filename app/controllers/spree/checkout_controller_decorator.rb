module Spree::CheckoutControllerDecorator
  def self.prepended(base)
    base.before_action :get_addresses
  end

  def get_addresses
    return unless spree_current_user && spree_current_user.wholesaler? && !spree_current_user.wholesaler.nil?
    @order.bill_address = spree_current_user.wholesaler.bill_address
    @order.ship_address = spree_current_user.wholesaler.ship_address
  end
end

Spree::CheckoutController.prepend Spree::CheckoutControllerDecorator
