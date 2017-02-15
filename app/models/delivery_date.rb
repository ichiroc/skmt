# frozen_string_literal: true
class DeliveryDate
  EARLIEST_DAYS = 3
  LATEST_DAYS = 14
  STRING_FORMAT = '%Y-%m-%d'

  def self.valid? date
    (earliest_date..latest_date).include? date
  end

  def self.earliest_date
    EARLIEST_DAYS.business_days.from_now.to_date
  end

  def self.formatted_earliest_date
    earliest_date.strftime STRING_FORMAT
  end

  def self.formatted_latest_date
    latest_date.strftime STRING_FORMAT
  end

  def self.latest_date
    LATEST_DAYS.business_days.from_now.to_date
  end

  def self.excluded_dates
    (earliest_date..latest_date).reject(&:workday?)
  end

  def self.formatted_excluded_dates
    excluded_dates.map { |d| d.strftime STRING_FORMAT }
  end
end
