FactoryBot.define do
  factory :wholesaler, class: Spree::Wholesaler do
    company { "Test Company" }
    buyer_contact { "Mr Contacter" }
    manager_contact { "Mr Manager" }
    phone { "555-555-5555" }
    fax { "555-555-5555 ext 1" }
    resale_number { "123456789" }
    taxid { "555-55-5555" }
    web_address { "testcompany.com" }
    terms { "Credit Card" }
    notes { "What a guy!" }
    user { create(:wholesale_user) }
    bill_address { create(:address) }
    ship_address { create(:address) }
  end
end
