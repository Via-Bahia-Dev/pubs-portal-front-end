module CommentsHelper
  def comment_date_format(datetime)
    datetime.strftime("%b %-d #{comment_year(datetime)}at %l:%M %p")
  end

  # for comments, only supply the year if it's not this year
  def comment_year(datetime)
    datetime.year != DateTime.now.year ? "#{datetime.year} " : ""
  end
end
