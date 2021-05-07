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
require "./greengrocer.rb"


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

greengrocer1 = Greengrocer.new(products_params1) #（★）商品インスタンス生成
# greengrocer2 = Greengrocer.new(products_params2) #商品インスタンス生成

#商品に追加するデータ
adding_products_params1 = [
  {name: "じゃがいも", price: 250},
  {name: "にんじん", price: 250}
]

greengrocer1.register_product(adding_products_params1) #（★）商品インスタンスの追加

user = User.new  #お客さんインスタンス生成

greengrocer1.disp_products #（★）商品の表示
# greengrocer2.disp_products #商品の表示
user.choose_product(greengrocer1.products)  #（★）商品の選択
greengrocer1.ask_quantity(user.chosen_product)  #（★）個数の確認
user.dicide_quantity #（★）個数の入力
greengrocer1.calculate_charges(user)  #（★）合計金額の計算