require 'minitest/autorun'
require 'minitest/pride'
require './lib/product'
require './lib/shopping_cart'
require 'pry'

class ShoppingCartTest < MiniTest::Test

  def test_instance_of
    cart = ShoppingCart.new("King Soopers", "30items")

    assert_instance_of ShoppingCart, cart
  end

  def test_shopping_cart_attributes
    cart = ShoppingCart.new("King Soopers", "30items")


    assert_equal "King Soopers", cart.name
    assert_equal 30, cart.capacity
    assert_equal [], cart.products
  end

  def test_add_products_to_shopping_cart
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    cart = ShoppingCart.new("King Soopers", "30items")
    cart.add_product(product1)
    cart.add_product(product2)

    detail = {:name => "King Soopers", :capacity => 30}
    assert_equal 2, cart.products.count
    assert_equal detail, cart.details
  end

  def test_shopping_cart_is_full
    cart = ShoppingCart.new("King Soopers", "30items")
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    product4 = Product.new(:produce, 'apples', 0.99, '20')
    cart.add_product(product1)
    cart.add_product(product2)
    cart.add_product(product3)
    cart.total_number_of_products

    assert_equal false, cart.is_full?
    cart.add_product(product4)

    assert_equal true, cart.is_full?
    assert_equal 2, cart.products_by_category(:paper).count
  end

  def test_shopping_cart_percentage_full
    cart = ShoppingCart.new("King Soopers", "30items")
    product1 = Product.new(:paper, 'toilet paper', 3.70, '10')
    product2 = Product.new(:meat, 'chicken', 4.50, '2')
    product3 = Product.new(:paper, 'tissue paper', 1.25, '1')
    product4 = Product.new(:produce, 'apples', 0.99, '20')
    cart.add_product(product1)
    cart.add_product(product2)
    cart.add_product(product3)
    assert_equal 43.33, cart.percentage_occupied

    cart.add_product(product4)
    assert_equal cart.sorted , cart.sorted_products_by_quantity

    breakdown = [{:paper=>["#<Product:0x00007ff19f0c2630>"]},
                 {:meat=>["#<Product:0x00007ff19f0c2540>"]},
                 {:paper=>["#<Product:0x00007ff19f0c24c8>"]},
                 {:produce=>["#<Product:0x00007ff19f0c2428>"]}]
    assert_equal breakdown, cart.product_breakdown
  end

end
