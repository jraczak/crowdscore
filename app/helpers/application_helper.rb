# -*- coding: utf-8 -*-

module ApplicationHelper
  def alert_messages
    type_mappings = { :notice => "info", :alert => "error" }

    [:notice, :alert].inject("") do |str, type|
      str << alert_message(type_mappings[type], flash[type]) if flash[type].present?
      str
    end.html_safe
  end

  def alert_message(type, message)
    "<div class=\"alert-message #{type}\"><p>#{message}</p></div>".html_safe
  end

  # FIXME: This is entirely a hack around Slim's poor capture handling
  def check_box_with_label(form_builder, method, label)
    form_builder.label(method) do
      form_builder.check_box(method) + content_tag(:span, label)
    end
  end
end
