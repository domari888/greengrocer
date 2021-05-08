class User
  attr_reader :chosen_product, :quantity_of_product

  #商品の選択
  def choose_product(products)
    while true
      print "商品の番号を選択 > "
      select_product_id = gets.to_i
      @chosen_product = products.find{|product| product.id == select_product_id}  #選んだ番号と同じ番号の商品を代入
      break if !@chosen_product.nil?
      puts "#{products.first.id} ~ #{products.last.id} の番号から選んでください。"
    end
  end

  #個数の入力
  def dicide_quantity
    while true
      print "個数を入力 > "
      @quantity_of_product = gets.to_i
      break if @quantity_of_product >= 1
      puts "1個以上選んでください。"
    end
  end
end
