class LdJsonBuilder
  def self._json(registration)
    res = {
      '@context': "http://schema.org",
      '@type': "Registration",
      reservationNumber: "E#{registration.id}",
      reservationStatus: "http://schema.org/Confirmed",
      underName: {
        '@type': "Person",
        name: registration.name,
      },
    }

    # if location
    #   res[:reservationFor][:location] = {
    #     '@type': 'Place',
    #     name: location.title,
    #     address: {
    #       '@type': 'PostalAddress',
    #       streetAddress: location.address,
    #       addressLocality: location.region.title,
    #       addressCountry: location.region.locale.upcase
    #     }
    #   }
    # end

    res.to_json
  end
end
