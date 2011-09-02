module DeviseHelper
  # Public: Format devise error messages in the same way we do everything else.
  #
  # Examples
  #
  #   devise_error_messages! # When devise errors are present
  #   # => '<div class="alert-message error"><p>Name can\'t be blank</p></div>'
  #
  #   See ApplicationHelper#errors_for.
  #
  # Returns a SafeBuffer string containing an error sentence.
  def devise_error_messages!
    errors_for resource
  end
end
