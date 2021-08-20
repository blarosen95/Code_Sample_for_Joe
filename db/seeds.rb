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
(1..25).each do |_iter|
  Patient.create(
    first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
    phone: Faker::PhoneNumber.phone_number.gsub(/\D/, '')[0..9],
    address: Faker::Address.street_address, created_at: DateTime.now, updated_at: :created_at # Is this illegal?
  )
end
Patient.create(
  first_name: 'John', last_name: 'Doe', email: 'JDoe@AnActualBakery.biz', phone: 7_274_095_959, address: '1 Drury LN'
) # Thanks for that guidance, rubocop. Obviously I went in knowing that phone as an integer was useless all around but it does at least showcase more than strings
