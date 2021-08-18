# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'faker'
require 'date'

# NOTE: there's likely a slight delay between datetime.now returns for created_at and updated_at in the creations below
# ... One might find that setting the initial value be done either here or in the controller ala the created_at value.
User.create(
  first_name: Faker::Name.first_name, last_name: Faker::Name.last_name, email: Faker::Internet.email,
  phone: Faker::PhoneNumber.cell_phone, address: Faker::Address.full_address, created_at: DateTime.now,
  updated_at: DateTime.now
)
