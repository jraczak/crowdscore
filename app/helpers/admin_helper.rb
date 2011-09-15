# -*- coding: utf-8 -*-

module AdminHelper
  def admin_subnav_item(text, path, expected_controller)
    if expected_controller == params[:controller]
      li_class = "active"
    end

    content_tag(:li, link_to(text, path), class: li_class)
  end
end
