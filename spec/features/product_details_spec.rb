require 'rails_helper'

RSpec.feature "Visitor can navigate from home page to product page by clicking on product", type: :feature, js: true do
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
  scenario "Visitors see product details" do

    visit root_path
    first('.product img').click

    save_and_open_screenshot

    expect(page).to have_text @category.name
    expect(page).to have_text @category.products[9].description

    save_and_open_screenshot
  end

end
