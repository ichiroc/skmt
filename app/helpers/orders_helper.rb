module OrdersHelper
  def default_datepicker_options
    {
      earliest_date: DeliveryDate.formatted_earliest_date,
      latest_date: DeliveryDate.formatted_latest_date,
      excluded_dates: DeliveryDate.excluded_dates
    }
  end
end
