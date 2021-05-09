describe "greengrocer_program" do
  # 商品データ
  let(:product_params1) do
    [
      {name: "トマト", price: 100},
      {name: "きゅうり", price: 200},
      {name: "玉ねぎ", price: 300},
      {name: "なす", price: 400}
    ]
  end
  # 八百屋さんの開店
  let(:greengrocer1){Greengrocer.new(product_params1)}
  # 商品の追加データ
  let(:adding_product_params1) do
    [
      {name: "じゃがいも", price: 250},
      {name: "にんじん", price: 250}
    ]
  end
  let(:products1){greengrocer1.products}
  # お客さん来店
  let(:user){User.new}
  let(:thank_msg){"お買い上げありがとうございました！"}

  shared_examples "正しい合計金額を含む，期待する表示がされること" do
    it do
      #商品の登録
      greengrocer1.register_product(adding_product_params1)
      # 商品の表示
      greengrocer1.disp_products
      # 商品の選択
      allow(ARGF).to receive(:gets).and_return correct_product_id_input
      user.choose_product(products1)  
      # 個数の確認
      greengrocer1.ask_quantity(user.chosen_product)  
      # 個数の選択
      allow(ARGF).to receive(:gets).and_return correct_quantity_input
      user.dicide_quantity 
      # 合計金額の計算
      expect{greengrocer1.calculate_charges(user)}.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
    end
  end
  shared_examples "割引した正しい合計金額を含む，期待する表示がされること" do
    it do
      greengrocer1.register_product(adding_product_params1)
      greengrocer1.disp_products
      allow(ARGF).to receive(:gets).and_return correct_product_id_input
      user.choose_product(products1)
      greengrocer1.ask_quantity(user.chosen_product)
      allow(ARGF).to receive(:gets).and_return correct_quantity_input
      user.dicide_quantity
      expect {greengrocer1.calculate_charges(user)}.to output("#{discount_msg}\n#{discount_total_price_msg}\n#{thank_msg}\n").to_stdout
    end
  end

  context "最初のidの商品が4個のとき"do
    # 商品の選択
    let(:correct_product_id_input){"#{products1.first.id}\n"}
    # 個数の選択
    let(:correct_quantity_input){"4\n"}
    # 合計金額の計算
    let(:total_price_msg){"合計金額は400円です。"}
    it_behaves_like "正しい合計金額を含む，期待する表示がされること" 
  end
  context "最後のidの商品が4個のとき" do
    let(:correct_product_id_input){"#{products1.last.id}\n"}
    let(:correct_quantity_input){"4\n"}
    let(:total_price_msg){"合計金額は1000円です。"}
    it_behaves_like "正しい合計金額を含む，期待する表示がされること" 
  end

  # let(:discount_msg){"5個以上なので10%割引となります！"}
  context "最初のidの商品が5個のとき"do
    let(:correct_product_id_input){"#{products1.first.id}\n"}
    let(:correct_quantity_input){"5\n"}
    let(:discount_msg){"5個以上なので10%割引となります！"}
    let(:discount_total_price_msg){"合計金額は450円です。"}
    it_behaves_like "割引した正しい合計金額を含む，期待する表示がされること"
  end
  context "最後のidの商品が5個のとき" do
    let(:correct_product_id_input){"#{products1.last.id}\n"}
    let(:correct_quantity_input){"5\n"}
    let(:discount_msg){"5個以上なので10%割引となります！"}
    let(:discount_total_price_msg){"合計金額は1125円です。"}
    it_behaves_like "割引した正しい合計金額を含む，期待する表示がされること"
  end
end