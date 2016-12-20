module ApplicationHelper
  def image_or_pdf_icon(url)
    if url[-4..-1] == ".pdf"
      image_tag("/assets/pdf.ico", class: "msg-pdf-icon")
    else
      image_tag(url, class: "msg-img")
    end
  end
end
