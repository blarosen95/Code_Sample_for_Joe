# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
Faker::Config.locale = 'en-US'
require 'date'

# NOTE: there's likely a slight delay between datetime.now returns for created_at and updated_at in the creations below
# ... One might find that setting the initial value be done either here or in the controller ala the created_at value.
(1..25).each do |iter_landlord|
  Landlord.create(
    first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number.gsub(/\D/, '')[0..9],
    address: Faker::Address.street_address, created_at: DateTime.now, updated_at: :created_at # Is this illegal?
  )
  (1..rand(1..7)).each do |_iter_room|
    rand(1..5).tap do |tenants_max|
      Room.create(
        landlord_id: iter_landlord, property_name: [Faker::Adjective.positive, Faker::House.room].join(' ').titleize,
        tenants_max: tenants_max, tenants_present: Faker::Number.between(from: 0, to: tenants_max),
        listed: Faker::Boolean.boolean(true_ratio: 0.88),
        restriction_pets: Faker::Boolean.boolean(true_ratio: 0.73),
        restriction_couples: Faker::Boolean.boolean(true_ratio: 0.64),
        property_address: Faker::Address.street_address
      )
    end
  end
end
