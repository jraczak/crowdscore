# -*- coding: utf-8 -*-

module AdminHelper
  def admin_subnav_item(text, path, expected_controller)
    li_class = "active" if case expected_controller
    when String
      expected_controller == params[:controller]
    when Regexp
      request.path =~ expected_controller
    else
      false
    end

    content_tag(:li, link_to(text, path), class: li_class)
  end
end
