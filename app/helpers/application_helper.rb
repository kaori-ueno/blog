module ApplicationHelper
  def format_ja_datetime(datetime)
    datetime.strftime("%Y年%m月%d日 %H:%M:%S")
  end

  def format_ja_date(datetime)
    datetime.strftime("%Y年%m月%d日")
  end
end
