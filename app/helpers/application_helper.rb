module ApplicationHelper
  def format_ja_datetime(datetime)
    datetime.strftime("%Y年%m月%d日 %H:%M:%S")
  end

  def format_ja_date(datetime)
    datetime.strftime("%Y年%m月%d日")
  end

  def format_text(text)
    text = h text
    text = text.gsub /\r\n|\r|\n/, "<br />"
    text.html_safe
  end
end
