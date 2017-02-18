module ZipCodeFormattable
  extend ActiveSupport::Concern
  def format_zip_code
    self.destination_zip_code = destination_zip_code.delete('-').strip
  end
end
