FactoryBot.define do
  factory :wholesale_variant, parent: :base_variant do
    wholesale_price { 9.50 }
  end
end
