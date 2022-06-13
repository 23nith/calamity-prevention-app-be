# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)


############### SEED FOR TESTS ##################

3.times do |x|
  Area.create!(address: "test address #{x + 1}", name: "test name #{x + 1}", longitude: 1.5, latitude: 1.5, radius: 1.5)
end

3.times do |x|
  Calamity.create!(area_id: Area.first.id, estimated_date_from: DateTime.now, estimated_date_to: DateTime.now + 1, description: "test description #{x + 1}", calamity_type: "test type #{x + 1}" )
end

3.times do |x|
  User.create!(area_id: Area.find(x + 1).id, email: "test#{x + 1}@email.com", password: "password", address: "test #{x + 1} address", first_name: "test#{x + 1}", last_name: "lastname #{x + 1}", longitude: 1.5, latitude: 1.5, role: "user", confirmed_at: DateTime.now)
end

3.times do |x|
  User.create!(area_id: Area.find(x + 1).id, email: "test#{x + 4}@email.com", password: "password", address: "test #{x + 4} address", first_name: "test#{x + 4}", last_name: "lastname #{x + 4}", longitude: 1.5, latitude: 1.5, role: "contact_person", confirmed_at: DateTime.now)
end

User.create!(area_id: Area.first.id, email: "test#{7}@email.com", password: "password", address: "test #{7} address", first_name: "test#{7}", last_name: "lastname #{7}", longitude: 1.5, latitude: 1.5, role: "admin", confirmed_at: DateTime.now )

Admin.create!(user_id: User.where(role: "admin").find(7).id)

3.times do |x|
  ContactPerson.create!(area_id: Area.find(x + 1).id, user_id: User.where(role: "contact_person").find(x + 4).id)
end


3.times do |x|
  Need.create!(calamity_id: Calamity.first.id, cost: 50, count: 3, description: "Need #{x + 1}")
end

3.times do |x|
  Donation.create!(user_id: User.first.id, need_id: Need.first.id, amount: 10)
end

3.times do |x|
  Message.create!(sender_id: User.where(role: "user").first.id, receiver_id: User.where(role: "contact_person").first.id, message_content: "help from user #{x + 1}")
end

3.times do |x|
  Message.create!(sender_id: User.where(role: "user").second.id, receiver_id: User.where(role: "contact_person").first.id, message_content: "help from user #{x + 1}")
end

3.times do |x|
  Message.create!(sender_id: User.where(role: "user").first.id, receiver_id: User.where(role: "contact_person").second.id, message_content: "help from user #{x + 1}")
end


##########################################################################################