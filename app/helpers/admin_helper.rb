# -*- coding: utf-8 -*-

module AdminHelper
  def admin_alert_messages
    type_mappings = { "notice" => "info", "alert" => "error" }
    %w(notice alert).inject("".html_safe) do |str, type|
      if flash[type].present?
        str << "<div class=\"alert-message #{type_mappings[type]}\"><a class=\"close\" href=\"#\">×</a><p>#{flash[type]}</p></div>".html_safe
      end
    end
  end
end
