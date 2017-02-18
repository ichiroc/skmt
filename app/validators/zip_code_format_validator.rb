# frozen_string_literal: true
class ZipCodeFormatValidator < ActiveModel::Validator
  ZIP_CODE_REGEXP = /\A\d{7}\Z/
  def validate(record)
    return if record.destination_zip_code.blank?
    unless record.destination_zip_code =~ ZIP_CODE_REGEXP
      record.errors.add(:destination_zip_code, I18n.t('errors.messages.destination_zip_code'))
    end
  end
end
