# require 'rails_helper'

# RSpec.describe Product, type: :model do

#   describe 'Validations' do

#     it 'should have a name, price, quantity and category' do 
#       product = Product.create(
#         name: "Whale Glue", 
#         price_cents: 1200, 
#         quantity: 43, 
#         category: Category.create()
#       )
#       expect(product[:name]).to be_present
#       expect(product[:price_cents]).to be_present
#       expect(product[:quantity]).to be_present
#       expect(product[:category_id]).to be_present
#     end

#     it 'should have a name' do 
#       product = Product.create(
#         name: nil, 
#         price_cents: 1200, 
#         quantity: 43, 
#         category: Category.create()
#       )

#       expect(product.errors.full_messages).to contain_exactly ("Name can't be blank")
#     end

#     it 'should have a price' do 
#       product = Product.create(
#         name: "Whale Glue", 
#         price: nil, 
#         quantity: 43, 
#         category: Category.create()
#       ) 
#       # expect(product.errors.full_messages).to contain_exactly("Price can't be blank")
#       puts product.errors.full_messages
#     end

#     it 'should have a quantity' do 
#       product = Product.create(
#         name: "Whale Glue", 
#         price_cents: 1200, 
#         quantity: nil, 
#         category: Category.create()
#       )
#       expect(product.errors.full_messages).to contain_exactly ("Quantity can't be blank")
#       # puts product.errors.full_messages
#     end

#     it 'should have a category' do 
#       product = Product.create(
#         name: "Whale Glue", 
#         price_cents: 1200, 
#         quantity: 43, 
#         category: nil
#       )
#       expect(product.errors.full_messages).to contain_exactly ("Category can't be blank")
#       # puts product.errors.full_messages
#     end
#   end
# end


require 'rails_helper'

RSpec.describe Product, type: :model do
  before(:each) do
    @category = Category.new()
  end
  context 'a product' do
    it 'accepts the product' do
      @product = Product.new(name: 'Whale Glue', price_cents: 1200, quantity: 43, :category => @category)
      expect(@product.errors).not_to include("can't be blank")
    end
  end

  context 'a product without a price' do
    it 'should raise an error' do
      @product = Product.new(name: 'Whale Glue', price_cents: nil, quantity: 43, :category => @category)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:price]).to include("can't be blank")
    end
  end

  context 'a product without a name' do
    it 'should raise an error' do
      @product = Product.new(name: nil, price_cents: 1200, quantity: 43, :category => @category)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:name]).to include("can't be blank")
    end
  end

  context 'a product without a quantity' do
    it 'should raise an error' do
      @product = Product.new(name: 'Whale Glue', quantity: nil, price_cents: 1200, :category => @category)
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:quantity]).to include("can't be blank")
    end
  end

  context 'a product without a category' do
    it 'should raise an error' do
      @product = Product.new(name: 'Whale Glue', price_cents: 5, quantity: 1, :category => nil )
      expect(@product).to_not be_valid
      expect(@product.errors.messages[:category]).to include("can't be blank")
    end
  end

end