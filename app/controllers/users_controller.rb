# frozen_string_literal: true

class UsersController < ApplicationController
  require 'oj'

  def index
    @users = User.all do |user|
      {
        first_name: user.first_name,
        last_name: user.last_name,
        email: user.email,
        phone: user.phone,
        address: user.address
      }
    end
    # @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @user.errors, status: :unprocessable_entity }
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @user.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      render json: { json: 'User was successfully deleted.' } # Would be cool to interpolate an attribute of the User here instead.
    else
      render json: { json: @user.errors, status: :unprocessable_entity }
    end
  end

  private

  def user_params
    params.require(:user).permit(:id, :first_name, :last_name, :email, :phone, :address)
  end
end
