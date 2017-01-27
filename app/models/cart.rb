# == Schema Information
#
# Table name: carts
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_carts_on_user_id  (user_id)
#

class Cart < ApplicationRecord
  belongs_to :user
end
