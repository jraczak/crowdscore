# This module contains methods that are basically hacked-in functions for
# libraries we're using. This means there is probably a better way, but we
# didn't have time to find it.
module HacketyHackHackHelper
  # FIXME: This is entirely a hack around Slim's poor capture handling
  def check_box_with_label(form_builder, method, label)
    form_builder.label(method) do
      form_builder.check_box(method) + " ".html_safe + content_tag(:span, label)
    end
  end
end
