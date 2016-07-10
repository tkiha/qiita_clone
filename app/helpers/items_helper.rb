module ItemsHelper
  def markdown_to_html(text_markdown)
    html = sanitize Kramdown::Document.new(text_markdown, kramdown_options).to_html
    content_tag :div, html, class: 'markdown'
  end

  private

  def kramdown_options
    { input: 'GFM', auto_ids: false, coderay_line_numbers: nil }
  end

end

