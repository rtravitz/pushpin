module ApplicationHelper
  def image_or_pdf_icon(message)
    if message.image_url[-4..-1] == ".pdf"
      image_tag("/assets/pdf.ico", class: "msg-pdf-icon")
    else
      image_tag(message.image_url, class: "msg-img")
    end
  end
end
