# -*- coding: utf-8 -*-

module ApplicationHelper
  def alert_messages
    type_mappings = { "notice" => "info", "alert" => "error" }
    %w(notice alert).inject("".html_safe) do |str, type|
      if flash[type.intern].present?
        str << "<div class=\"alert-message #{type_mappings[type]}\"><p>#{flash[type.intern]}</p></div>".html_safe
      end
      str
    end
  end

  # FIXME: This is entirely a hack around Slim's poor capture handling
  def check_box_with_label(form_builder, method, label)
    form_builder.label(method) do
      form_builder.check_box(method) + content_tag(:span, label)
    end
  end
end
