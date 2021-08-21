# frozen_string_literal: true

class RoomsController < ApplicationController
  def index
    @rooms = Room.all
    render json: @rooms
  end

  def show
    @room = Room.find(params[:id])
    render json: @room
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @room.errors, status: :unprocessable_entity }
    end
  end

  def update
    @room = Room.find(params[:id])
    if @room.update(room_params)
      render json: { status: :ok, message: 'Success' }
    else
      render json: { json: @room.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    @room = Room.find(params[:id])
    if @room.destroy
      render json: { status: :ok, message: 'Room was successfully deleted.' }
    else
      render json: { json: @room.errors, status: :unprocessable_entity }
    end
  end

  private

  def room_params
    params.require(:room).permit(:id, :property_name, :property_address, :tenants_max, :tenants_present, :listed,
                                 :restriction_pets, :restriction_couples)
  end
end
