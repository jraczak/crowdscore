module DeviseHelper
  def devise_error_messages!
    return "" if resource.errors.empty?

    messages = resource.errors.full_messages.join(", ")

    alert_message(:error, messages).html_safe
  end
end
