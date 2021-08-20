# frozen_string_literal: true

class PatientsController < ApplicationController
  require 'oj'

  def index
    @patients = Patient.all do |patient|
      {
        first_name: patient.first_name,
        last_name: patient.last_name,
        email: patient.email,
        phone: patient.phone,
        address: patient.address
      }
    end
    # @patients = Patient.all
    render json: @patients
  end

  def create
    @patient = Patient.new(patient_params)
    if @patient.save
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @patient.errors, status: :unprocessable_entity }
    end
  end

  def update
    @patient = Patient.find(params[:id])
    if @patient.update(patient_params)
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @patient.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @patient = Patient.find(params[:id])
    if @patient.destroy
      render json: { json: 'Patient was successfully deleted.' } # Would be cool to interpolate an attribute of the Patient here instead.
    else
      render json: { json: @patient.errors, status: :unprocessable_entity }
    end
  end

  private

  def patient_params
    params.require(:patient).permit(:id, :first_name, :last_name, :email, :phone, :address)
  end
end
