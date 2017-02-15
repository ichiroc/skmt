# frozen_string_literal: true
class DeliveryDateValidator < ActiveModel::Validator
  def validate(record)
    return if record.delivery_date.blank?
    return if DeliveryDate.valid?(record.delivery_date)
    record.errors.add(:delivery_date, t('errors.messages.invalid_delivery_date'))
  end
end
