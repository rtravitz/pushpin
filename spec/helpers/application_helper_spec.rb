require 'rails_helper'
require './app/helpers/application_helper'
include ApplicationHelper

describe "helper methods" do
  context "image_or_pdf_icon" do
    it "decides whether a url is a pdf or an image" do
      pdf = "test_link.pdf"
      image = "test_image.jpeg"
      
      expect(image_or_pdf_icon(pdf)).to eq("<img class=\"msg-pdf-icon\" src=\"/assets/pdf.ico\" alt=\"Pdf\" />")
      expect(image_or_pdf_icon(image)).to eq("<img class=\"msg-img\" src=\"/images/test_image.jpeg\" alt=\"Test image\" />")
    end
  end
end
