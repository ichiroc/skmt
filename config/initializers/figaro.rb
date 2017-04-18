# frozen_string_literal: true
if Rails.env == 'production'
  Figaro.require_keys(
    'SKMT_DATABASE_NAME',
    'SKMT_DATABASE_USERNAME',
    'SKMT_DATABASE_PASSWORD'
  )
end
