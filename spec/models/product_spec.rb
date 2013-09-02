require 'spec_helper'
describe Product do
  context "Productが空のとき" do
    subject {Product.new}
    before {subject.valid?}
    it {should be_invalid}
    it {subject.errors[:title].should_not be_empty}
    it {subject.errors[:description].should_not be_empty}
    it {subject.errors[:price].should_not be_empty}
    it {subject.errors[:image_url].should_not be_empty}
  end
  
  context "priceの値に数値が入っているとき" do
    subject {Product.new(title:       "My Book Title",
                         description: "yyy",
                         image_url:   "zzz.jpg")}
    it "priceの値が負のときinvalid" do
      subject.price = -1
      should be_invalid
      subject.errors[:price].should include "must be greater than or equal to 0.01" 
    end

    it "priceの値が0のときinvalid" do
      subject.price = 0
      should be_invalid
      subject.errors[:price].should include "must be greater than or equal to 0.01" 
    end

    it "priceの値が正のときvalid" do
      subject.price = 1
      should be_valid
    end
  end

  context "画像のURLが記入されているとき" do
    subject {Product.new(title:       "My Book Title",
                         description: "yyy",
                         price:       1,
                         image_url:   image_url)}
    ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif }
    ok.each do |url|
      describe "urlが#{url}のとき" do 
        let(:image_url) {url}
        it {should be_valid}
      end
    end

    bad = %w{ fred.doc fred.gif/more fred.gif.more }
    bad.each do |url|
      describe "urlが#{url}のとき" do
        let(:image_url) {url}
        it {should be_invalid}
      end
    end
  end

  context "title名が記入されているとき" do
    before {FactoryGirl.create(:product_ruby)}
    subject {FactoryGirl.build(:product_ruby, description: "yyy",
                                              price:       1,
                                              image_url:   "fred.gif")}
    it {subject.save.should be_false}
    it {subject.valid?
      subject.errors[:title].should include I18n.translate('activerecord.errors.messages.taken')}
  end

  describe "the truth" do
    subject {true}
    it {should be_true}
  end
end
