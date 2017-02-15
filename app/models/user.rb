# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  confirmation_token     :string
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string
#  name                   :string
#  zip_code               :string
#  address                :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#

class User < ApplicationRecord
  rolify
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable

  has_one :cart, required: true
  has_many :orders, dependent: :destroy
  has_many :roles, through: :users_roles
  before_validation :build_cart, if: -> { cart.blank? }
  before_destroy :dont_delete_last_admin

  def is_admin= flag
    if flag == '1'
      add_role :admin
    else
      remove_role :admin
    end
  end

  private

  def dont_delete_last_admin
    return unless is_admin?
    number_of_admins = User.joins(:users_roles)
                           .joins(:roles)
                           .where('roles.name = ?', 'admin')
                           .count
    return if number_of_admins > 1
    errors.add(:base, I18n.t('errors.messages.cant_delete_last_admin'))
    throw :abort
  end
end
