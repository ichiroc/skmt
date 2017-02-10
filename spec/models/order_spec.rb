require 'rails_helper'

RSpec.describe Order, type: :model do
  subject(:order) { build :order }
  it{ is_expected.to be_valid }
end
