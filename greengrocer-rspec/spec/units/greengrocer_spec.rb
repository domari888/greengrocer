RSpec.describe Greengrocer do
  let(:product_params) do
    [
      {name: "トマト", price: 100},
      {name: "きゅうり", price: 200}
    ]
  end
  let(:greengrocer){Greengrocer.new(product_params)}

  describe ".initialize" do
    let(:products){greengrocer.products}
    context "インスタンスが生成されたとき" do
      it "@productsの要素の数が，product_paramsの要素の数と等しいこと" do
        expect(products.size).to eq 2
      end

      it "@productsの最初の要素の名前が，product_paramsの最初の要素の名前と等しいこと" do
        expect(products[0].name).to eq "トマト"
      end

      it "@productsの最初の要素の金額が，product_paramsの最初の要素の金額と等しいこと" do
        expect(products[0].price).to eq 100
      end
    end
  end

  describe ".register_product" do
    let(:adding_products_params) do
      [
        {name: "じゃがいも", price: 250},
        {name: "にんじん", price: 250}
      ]
    end
    let(:products){greengrocer.products}
    before{greengrocer.register_product(adding_products_params)}

    it "@productsの要素の数が，「product_paramsとadding_product_paramsの要素の数の和」と等しいこと" do
      expect(products.size).to eq 4
    end

    it "@productsの最後の要素の名前が，adding_product_paramsの最後の要素の名前と等しいこと" do
      expect(products[-1].name).to eq "にんじん"
    end

    it "@productsの最後の要素の金額が，adding_product_paramsの最後の要素の金額と等しいこと" do
      expect(products[-1].price).to eq 250
    end
  end

  describe ".disp_products" do
    let(:base_id){Product.class_variable_get("@@count")}
    let(:hello_msg){"いらっしゃいませ！商品を選んでください。"}
    let(:product_msg1){"#{base_id + 1}. トマト(100円)"}
    let(:product_msg2){"#{base_id + 2}. きゅうり(200円)"}
    let(:msg){"#{hello_msg}\n#{product_msg1}\n#{product_msg2}\n"}
    it "期待する表示がされること" do
      expect{greengrocer.disp_products}.to output(msg).to_stdout
    end
  end

  describe ".ask_quantity" do
    let(:chosen_product){Product.new({name: "玉ねぎ", price: 300})}
    let(:ask_msg){"玉ねぎですね。何個買いますか？\n"}
    it "userが選択した商品の名前を含む，期待する表示がされること" do
      expect{greengrocer.ask_quantity(chosen_product)}.to output(ask_msg).to_stdout
    end
  end

  describe ".calculate_charges" do
    let(:user){User.new}
    let(:thank_msg){"お買い上げありがとうございました！"}

    context "300円の商品（玉ねぎ）が4個のとき" do 
      let(:total_price_msg){"合計金額は1200円です。"}
      it "正しい合計金額を含む，期待する表示がされること" do
        user.instance_variable_set("@chosen_product", Product.new({name: "玉ねぎ", price: 300}))
        user.instance_variable_set("@quantity_of_product", 4)
        expect{greengrocer.calculate_charges(user)}.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
      end
    end
    context "400円の商品（なす）が4個のとき" do
      let(:total_price_msg){"合計金額は1600円です。"}
      it "正しい合計金額を含む，期待する表示がされること" do
        user.instance_variable_set("@chosen_product", Product.new({name: "なす", price: 400}))
        user.instance_variable_set("@quantity_of_product", 4)
        expect{greengrocer.calculate_charges(user)}.to output("#{total_price_msg}\n#{thank_msg}\n").to_stdout
      end
    end
    context "300円の商品（玉ねぎ）が5個のとき" do
      let(:discount_msg){"5個以上なので10%割引となります！"}
      let(:discount_total_price_msg){"合計金額は1350円です。"}
      it "割引した正しい合計金額を含む、期待する表示がされること" do
        user.instance_variable_set("@chosen_product", Product.new({name: "玉ねぎ", price: 300}))
        user.instance_variable_set("@quantity_of_product", 5)
        expect{greengrocer.calculate_charges(user)}.to output("#{discount_msg}\n#{discount_total_price_msg}\n#{thank_msg}\n").to_stdout
      end
    end
    context "400円の商品（なす）が5個のとき" do
      let(:discount_msg){"5個以上なので10%割引となります！"}
      let(:discount_total_price_msg){"合計金額は1800円です。"}
      it "割引した正しい合計金額を含む、期待する表示がされること" do
        user.instance_variable_set("@chosen_product", Product.new({name: "なす", price: 400}))
        user.instance_variable_set("@quantity_of_product", 5)
        expect{greengrocer.calculate_charges(user)}.to output("#{discount_msg}\n#{discount_total_price_msg}\n#{thank_msg}\n").to_stdout
      end
    end

  end

end