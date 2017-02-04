# frozen_string_literal: true
class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :not_permitted, unless: 'current_user.is_admin?'
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  def index
    @admin_users = User.all
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @admin_user.update(admin_user_params)
        format.html { redirect_to admin_user_path @admin_user, notice: 'User was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private

  def set_admin_user
    @admin_user = User.find(params[:id])
  end

  def admin_user_params
    permitted_attr = [:name, :email, :zip_code, :address, :is_admin]
    unless params[:user][:password].blank?
      permitted_attr << :password
      permitted_attr << :password_confirmation
    end
    params.require(:user).permit(*permitted_attr)
  end
end
