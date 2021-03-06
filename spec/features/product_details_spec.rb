require 'rails_helper'

RSpec.feature "ProductDetail", type: :feature, js: true do

  # SETUP
  before :each do
    @category = Category.create! name: 'Apparel'

    10.times do |n|
      @category.products.create!(
        name: Faker::Hipster.sentence(3),
        description: Faker::Hipster.paragraph(4),
        image: open_asset('apparel1.jpg'),
        quantity: 10,
        price: 64.99
      )
    end
  end


  scenario "They see the details of the product" do
    # ACT
    visit root_path
    
    click_on('Details »', match: :first)
    # find_link('Details »', match: :first).click

    sleep 5
    puts page.html
    # DEBUG / VERIFY
    save_screenshot

    # VERIFY

    expect(page).to have_css 'article.product-detail', count: 1
  end

end