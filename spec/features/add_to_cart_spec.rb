require 'rails_helper'

RSpec.feature "user click add to cart button for a product", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name:  Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end
  scenario "number of items added to cart will be updated" do

    visit root_path
    first('.button_to').click

    expect(page).to have_text "My Cart (1)"
    
    save_and_open_screenshot
    
  end

end
