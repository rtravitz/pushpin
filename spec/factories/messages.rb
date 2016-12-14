FactoryGirl.define do
  factory :message do
    body "MyText"
    image_url "MyString"
    user nil
    proposal nil
  end
end
