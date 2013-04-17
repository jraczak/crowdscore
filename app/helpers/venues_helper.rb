module VenuesHelper
  def inline_address(venue)
    parts = [venue.address1, venue.address2, "#{venue.city}, #{venue.state} #{venue.zip}"].reject(&:blank?)

    parts.map! { |p| h(p) }
    parts.join(' ').html_safe
    #parts.join('<br />').html_safe
  end
  
  def formatted_inline_address(venue)
    "#{venue.address1} #{venue.address2} <br>
    #{venue.city}, #{venue.state} #{venue.zip}"
  end
end
