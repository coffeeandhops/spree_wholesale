class Spree::Wholesaler < ActiveRecord::Base
  partial_updates = false

  belongs_to :user, :class_name => "Spree::User"
  belongs_to :bill_address, :foreign_key => "billing_address_id", :class_name => "Spree::Address", :dependent => :destroy
  belongs_to :ship_address, :foreign_key => "shipping_address_id", :class_name => "Spree::Address", :dependent => :destroy

  accepts_nested_attributes_for :bill_address
  accepts_nested_attributes_for :ship_address
  accepts_nested_attributes_for :user

  attr_accessor :use_billing
  before_validation :clone_billing_address, if: :use_billing
  validates :company, :buyer_contact, :phone, :presence => true
  
  delegate :spree_roles, to: :user
  delegate :email, to: :user

  def activate!
    get_wholesale_role
    return false if user.spree_roles.include?(@role)
    user.spree_roles << @role
    WholesaleMailer.approve_wholesaler_email(self).deliver
    user.save
  end

  def deactivate!
    get_wholesale_role
    return false unless user.spree_roles.include?(@role)
    user.spree_roles.delete(@role)
    user.save
  end

  def active?
    user && user.has_spree_role?("wholesaler")
  end

  def self.term_options
    ["Credit Card", "Net 30"]
  end

  private

  def get_wholesale_role
    @role = Spree::Role.find_or_create_by_name("wholesaler")
  end

  def clone_billing_address
    if bill_address and self.ship_address.nil?
      self.ship_address = bill_address.clone
    else
      self.ship_address.attributes = bill_address.attributes.except("id", "updated_at", "created_at")
    end
    true
  end
end
