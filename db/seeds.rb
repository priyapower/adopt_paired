# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# @image_1 = "https://www.101dogbreeds.com/wp-content/uploads/2019/01/Chihuahua-Mixes.jpg"
# @image_2 = "https://www.loveyourdog.com/wp-content/uploads/2019/12/Catahoula-Pitbull-Mix-900x500.jpg"
# @image_3 = "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/47475338/2/?bust=1586831049&width=720"
# @image_4 = "https://www.iamcasper.com/wp-content/uploads/2018/03/Torbie-Ragdoll-1030x790.png"
#
#
# Shelter.create(name: "The Humane Society - Denver", address: "1 Place St", city: "Denver", state: "Denver", zip: "11111")
# Shelter.create(name: "Denver Animal Shelter", address: "7 There Blvd", city: "Denver", state: "Denver", zip: "22222")
# Shelter.create(name: "A Third Place", address: "3 Street", city: "Denver", state: "Denver", zip: "33333")
# Pet.create(image: "#{@image_1}", name: "Tinkerbell", approximate_age: "3", sex: "Female", description: "Adorable chihuahua mix with lots of love to give")
# Pet.create(image: "#{@image_2}", name: "George", approximate_age: "5", sex: "Male", description: "This pitty mix will melt your heart with his sweet temperament")
# Pet.create(image: "#{@image_3}", name: "Ruby", approximate_age: "0.7", sex: "Female", description: "This flat-coated retriever mix is your best friend on walks and is perfect for families with kids")
# Pet.create(image: "#{@image_4}", name: "Pierce Brosnan", approximate_age: "7", sex: "Male", description: "This ragdoll mix is a fluffy and friendly addition to your household")

# Rails.application.load_seed

Pet.destroy_all
Shelter.destroy_all

# @shelter_1 = Shelter.create!(name: "Pawz",
#   address: "1 Place St",
#   city: "Denver",
#   state: "CO",
#   zip: "11111")
#
#
#   review_1 = @shelter_1.reviews.create!(title: 'Amazing', rating: 5, content: 'Found my best friend', image: 'https://live.staticflickr.com/7396/8728178651_912c2fa554_b.jpg')
