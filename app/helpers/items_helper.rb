module ItemsHelper
  def markdown_to_html(text_markdown)
    raw '<div class="markdown">' + Kramdown::Document.new(text_markdown, kramdown_options).to_html + '</div>'
  end

  private

  def kramdown_options
    { input: 'GFM', auto_ids: false, coderay_line_numbers: nil }
  end

end

