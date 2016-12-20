module ApplicationHelper
  def image_or_pdf_icon(message)
    if message.image_url[-4..-1] == ".pdf"
      "/assets/pdf.ico" 
    else
      message.image_url
    end
  end
end
