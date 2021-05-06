class Greengrocer
  attr_reader :products
  def initialize(products_params)
    @products = []
    register_product(products_params)  #商品を追加するメソッドの呼び出し
  end

  #商品の追加
  def register_product(product_params)
    product_params.each do |param|
      @products << Product.new(param)  #商品インスタンスを1つずつ配列に代入
    end
  end

  #商品の表示
  def disp_products
    puts "いらっしゃいませ！商品を選んでください。"
    @products.each do |product|
      puts "#{product.id}. #{product.name}(#{product.price}円)"
    end
  end

  #個数の確認
  def ask_quantity(chosen_product)
    puts "#{chosen_product.name}ですね。何個買いますか？"
  end

  #合計金額の計算
  def calculate_charges(user)
    total_price = user.chosen_product.price * user.quantity_of_product
    if user.quantity_of_product >= 5
      puts "5個以上なので10%割引となります！"
      total_price *= 0.9
    end
    puts "合計金額は#{total_price.floor}円です。"
    puts "お買い上げありがとうございました！"
  end

  # def calculate_charges(chosen_product, quantity_of_product)
  #   total_price = chosen_product.price * quantity_of_product
  #   if quantity_of_product >= 5
  #     puts "5個以上なので10%割引となります！"
  #     total_price *= 0.9
  #   end
  #   puts "合計金額は#{total_price.floor}円です。"
  #   puts "お買い上げありがとうございました！"
  # end

end
