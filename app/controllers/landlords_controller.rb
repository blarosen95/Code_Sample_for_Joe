# frozen_string_literal: true

class LandlordsController < ApplicationController
  require 'oj' #  TODO: Really squeeze out the potential here, not focusing too heavily on worst-case execution times
  # (TODO continued) as this is running on just an i5-6200U. Would like to see non-compilation times <= maybe 600ms
  # (TODO continued) such times would translate to a modest i7 (non-mobile) processor achieving 8 to 20 ms.
  # If you're reading these comments, don't judge too harshly. My home-lab is down until I finish moving, and I'm stuck
  # on an awful laptop.

  def index
    @landlords = Landlord.all do |landlord|
      {
        first_name: landlord.first_name,
        last_name: landlord.last_name,
        email: landlord.email,
        phone: landlord.phone,
        address: landlord.address
      }
    end
    # @patients = Patient.all
    render json: @landlords
  end

  def show
    @landlord = Landlord.find(params[:id])
    render json: @landlord
  end

  def create
    @landlord = Landlord.new(landlord_params)
    if @landlord.save
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @landlord.errors, status: :unprocessable_entity }
    end
  end

  def update
    @landlord = Landlord.find(params[:id])
    if @landlord.update(landlord_params)
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @landlord.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @landlord = Landlord.find(params[:id])
    if @landlord.destroy
      render json: { json: 'Landlord was successfully deleted.' }
    else
      render json: { json: @landlord.errors, status: :unprocessable_entity }
    end
  end

  private

  def landlord_params
    params.require(:landlord).permit(:id, :first_name, :last_name, :email, :phone, :address)
  end
end
