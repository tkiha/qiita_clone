module ItemsHelper
  def qiita_markdown(text_markdown)
    processor = Qiita::Markdown::Processor.new
    result = processor.call(text_markdown)
    html = result[:output]
    raw html
  end
end
