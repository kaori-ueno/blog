module ApplicationHelper
  def format_ja_datetime(datetime)
    datetime.strftime("%Y年%m月%d日 %H:%M:%S")
  end

  def format_ja_date(datetime)
    datetime.strftime("%Y年%m月%d日")
  end

  def format_datetime(datetime)
    datetime.strftime("%Y-%m-%d %H:%M:%S")
  end

  def format_date(datetime)
    datetime.strftime("%Y-%m-%d")
  end

  def format_text(text)
    unless @markdown
      renderer = Redcarpet::Render::HTML.new
      @markdown = Redcarpet::Markdown.new renderer
    end
    @markdown.render(text).html_safe
  end
end
