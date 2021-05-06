# 八百屋さん
#   商品の表示
#   個数確認
#   合計金額
# お客さん
#   商品の選択
#   個数の入力

# 商品を表示
# 商品を選択
# 個数を選択
# 合計を計算

require "./product.rb"
require "./user.rb"

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

#1店舗目
products_params1 = [
  {name: "トマト", price: 100},
  {name: "きゅうり", price: 200},
  {name: "玉ねぎ", price: 300},
  {name: "なす", price: 400}
]

# #2店舗目
# products_params2 = [
#   {name: "キャベツ", price: 150},
#   {name: "レタス", price: 250}
# ]

greengrocer1 = Greengrocer.new(products_params1) #商品インスタンス生成
# greengrocer2 = Greengrocer.new(products_params2) #商品インスタンス生成

#商品に追加するデータ
adding_products_params1 = [
  {name: "じゃがいも", price: 250},
  {name: "にんじん", price: 250}
]

greengrocer1.register_product(adding_products_params1) #商品インスタンスの追加

user = User.new  #お客さんインスタンス生成

greengrocer1.disp_products #商品の表示
# greengrocer2.disp_products #商品の表示
user.choose_product(greengrocer1.products)  #商品の選択
greengrocer1.ask_quantity(user.chosen_product)  #個数の確認
user.dicide_quantity #個数の入力
greengrocer1.calculate_charges(user)  #合計金額の計算
# greengrocer1.calculate_charges(user.chosen_product, user.quantity_of_product)