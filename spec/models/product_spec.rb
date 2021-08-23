require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do
    # validation tests/examples here
    it("should save when all fields are present") do
      @category = Category.new
      @category.name = "Kitchenware"
      @product = Product.new
      @product.name = "Kettle"
      @product.price = 35
      @product.quantity = 5
      @product.category = @category
      expect(@product).to be_present
    end
    it("should not validate without product name") do
      @category = Category.new
      @category.name = "Kitchenware"
      @category.save
      @product = Product.new
      @product.name = nil
      @product.price = 35
      @product.quantity = 5
      @product.category = @category
      @product.save
      expect(@product.errors.full_messages).to include "Name can't be blank"
    end
    it("should not validate without product price") do
      @category = Category.new
      @category.name = "Kitchenware"
      @category.save
      @product = Product.new
      @product.name = "kettle"
      @product.price = nil
      @product.quantity = 5
      @product.category = @category
      @product.save
      expect(@product.errors.full_messages).to include "Price can't be blank"
    end
    it("should not validate without product quantity") do
      @category = Category.new
      @category.name = "Kitchenware"
      @category.save
      @product = Product.new
      @product.name = "kettle"
      @product.price = 35
      @product.quantity = nil
      @product.category = @category
      @product.save
      expect(@product.errors.full_messages).to include "Quantity can't be blank"
    end
    it("should not validate without product quantity") do
      @category = Category.new
      @category.name = "Kitchenware"
      @category.save
      @product = Product.new
      @product.name = "kettle"
      @product.price = 35
      @product.quantity = 5
      @product.category = nil
      @product.save
      expect(@product.errors.full_messages).to include "Category can't be blank"
    end
  end
end
