require 'will_paginate/core_ext'
require 'will_paginate/view_helpers'
require 'will_paginate/view_helpers/link_renderer'

module WillPaginate
  module ActionView
    class TwitterBootstrapLinkRenderer < LinkRenderer
      def html_container(html)
        super(tag(:ul, html))
      end

      def page_number(page)
        state = "active" if page == current_page
        link(page, page, :rel => rel_value(page), :li_class => state)
      end

      def link(text, target, attributes = {})
        li_class = attributes.delete(:li_class)
        tag(:li, super, :class => li_class)
      end

      def gap
        text = @template.will_paginate_translate(:page_gap) { '&hellip;' }
        %(<li class="disabled"><a href="#">#{text}</a></li>)
      end

      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page(num, @options[:previous_label], 'prev')
      end

      def next_page
        num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
        previous_or_next_page(num, @options[:next_label], 'next')
      end

      protected

      def previous_or_next_page(page, text, classname)
        li_class = page ? classname : "#{classname} disabled"
        link(text, page || "#", :li_class => li_class)
      end
    end
  end
end
