# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def stylesheets
    stylesheet_link_tag 'common',
      'facybox',
      'form',
      :cache => true
  end

  def javascripts
    javascript_include_tag 'jquery',
      'jrails',
      'facybox',
      'application',
      :cache => true
  end
  
  def format_date(date)
    date.strftime('%A, %B %d, %Y')
  end
  
end
