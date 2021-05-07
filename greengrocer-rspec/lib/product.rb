class Product
  attr_reader :id, :name, :price 
  @@count = 30

  def initialize(products_params)
     @id = @@count += 1
    @name = products_params[:name]
    @price = products_params[:price]
  end
end
