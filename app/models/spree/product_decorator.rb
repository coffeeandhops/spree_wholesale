Spree::PermittedAttributes.product_attributes << :wholesale_price

module Spree::ProductDecorator
  def self.prepended(base)
    base.delegate :wholesale_price, to: :master if Spree::Variant.table_exists? && Spree::Variant.column_names.include?("wholesale_price")
  end
    
  def is_wholesaleable?
    0.01 < master.wholesale_price
  end

  def self.wholesaleable
    wholesale_products = []
    all.each do |p|
      wholesale_products << p if p.is_wholesaleable?
    end
    wholesale_products
  end

end

Spree::Product.prepend Spree::ProductDecorator
