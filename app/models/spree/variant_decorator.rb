Spree::PermittedAttributes.variant_attributes << :wholesale_price

module Spree::VariantDecorator
  def self.prepended(base)
    base.scope :wholesales, ->{where("spree_variants.wholesale_price > 0")}
  end

  def is_wholesaleable?
    0 < wholesale_price
  end

end

Spree::Variant.prepend Spree::VariantDecorator
