FactoryBot.define do
  
  # factory :user, :class => Spree::User do
  #   email { random_email }
  #   password { "spree123" }
  #   password_confirmation { "spree123" }
  #   spree_roles { [Spree::Role.find_or_create_by_name("user")] }
  # end

  # factory :admin_user, :parent => :user do
  #   spree_roles { [Spree::Role.find_or_create_by_name("admin")] }
  # end

  factory :wholesale_user, :parent => :user do
    spree_roles { [Spree::Role.find_or_create_by(name: "wholesaler")] }
  end

end