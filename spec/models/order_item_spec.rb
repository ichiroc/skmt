require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  subject(:order_item) { build :order_item }
  it{ is_expected.to be_valid }
end
