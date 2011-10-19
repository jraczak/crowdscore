module VenuesHelper
  def inline_address(venue)
    parts = [venue.address1, venue.address2, "#{venue.city}, #{venue.state} #{venue.zip}"].reject(&:blank?)

    parts.map! { |p| h(p) }
    parts.join('<br />').html_safe
  end
end
