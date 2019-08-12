# frozen_string_literal: true

module RbNaCl
  ALG = "ED25519"
  PRIVATE_KEY = RbNaCl::Signatures::Ed25519::SigningKey.new Rails.application.secrets.jwt_key
  PUBLIC_KEY = PRIVATE_KEY.verify_key
end
