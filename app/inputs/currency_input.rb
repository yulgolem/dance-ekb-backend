class CurrencyInput < IntegerAddonInput
  def addon
    # '&#x20bd;'
    I18n.t("currency_sign")
  end
end
