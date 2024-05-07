module ApplicationHelper
  def page_title(page_title = '', admin: false)
    base_title = 'TokyoPicnic'

    page_title.empty? ? base_title : "#{page_title} | #{base_title}"
  end
end
