class ShoppingCart
  attr_reader :name,
              :capacity,
              :products,
              :sorted,
              :breakdown

  def initialize(name, capacity)
    @name = name
    @capacity = capacity.to_i
    @products = []
    @sorted = []
    @breakdown = []
  end

  def add_product(product)
    @products << product
  end

  def details
    detail = {
      name: "#{@name}",
      capacity: @capacity}
  end

  def total_number_of_products
    products.sum do |product|
      product.quantity
    end
  end

  def products_by_category(category)
    products.select do |product|
      product.category == category
    end
  end

  def percentage_occupied
    ((total_number_of_products.to_f / capacity.to_f) * 100).round(2)
  end

  def sorted_products_by_quantity
    @sorted << products.sort_by do |product|
      product.quantity
    end
  end

  def product_breakdown
    products.collect do |product|
      key = product.category
      value = ["#{product}"]
      breakdown = {key => value}
    end
  end

  def is_full?
    if @capacity <= total_number_of_products
      true
    else
      false
    end
  end

end
