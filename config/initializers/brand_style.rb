# frozen_string_literal: true

module ImiProject
  module BrandStyle
    COLORS = {
      white: "#FFFFFF",
      black: "#1C1C1C",
      accent: "#8BC540",
      error: "#FF6E6E",
      light_green: "#C6F9C6",
      light_purple: "#FDB0AB",
      light_blue: "#D0E6FD",
      light_yellow: "#FFEE96",
    }.freeze

    CERTIFICATE_COLORS = COLORS.slice(
      :light_green,
      :light_purple,
      :black,
      :accent,
      :light_blue,
    ).freeze
  end
end
