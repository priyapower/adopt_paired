# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
shelter_1 = Shelter.create(name: "The Humane Society - Denver",
  address: "1 Place St",
  city: "Denver",
  state: "CO",
  zip: "11111")
shelter_2 = Shelter.create(name: "Denver Animal Shelter",
  address: "7 There Blvd",
  city: "Denver",
  state: "CO",
  zip: "22222")

pet_1 = shelter_1.pets.create(image: "https://www.101dogbreeds.com/wp-content/uploads/2019/01/Chihuahua-Mixes.jpg",
  name: "Tinkerbell",
  approximate_age: 3,
  sex: "Female",
  description: "Adorable chihuahua mix with lots of love to give",
  status: true)
pet_2 = shelter_1.pets.create(image: "https://www.loveyourdog.com/wp-content/uploads/2019/12/Catahoula-Pitbull-Mix-900x500.jpg",
  name: "George",
  approximate_age: 5,
  sex: "Male",
  description: "This pitty mix will melt your heart with his sweet temperament",
  status: true)
pet_3 = shelter_2.pets.create(image: "https://dl5zpyw5k3jeb.cloudfront.net/photos/pets/47475338/2/?bust=1586831049&width=720",
  name: "Ruby",
  approximate_age: 0,
  sex: "Female",
  description: "This flat-coated retriever mix is your best friend on walks and is perfect for families with kids",
  status: true)
pet_4 = shelter_2.pets.create(image: "https://www.iamcasper.com/wp-content/uploads/2018/03/Torbie-Ragdoll-1030x790.png",
  name: "Pierce Brosnan",
  approximate_age: 7,
  sex: "Male",
  description: "This ragdoll mix is a fluffy and friendly addition to your household",
  status: true)

application_1 = Apply.create(name: "Third Person",
  address: "96 There St",
  city: "CityPlace",
  state: "StateLocation",
  zip: 88888,
  phone_number: "(555)555-5555",
  description: "1.Person from Apply Index Test")
application_2 = Apply.create(name: "Fourth Person",
  address: "96 There St",
  city: "CityPlace",
  state: "StateLocation",
  zip: 88888,
  phone_number: "(555)555-5555",
  description: "2.Person from Apply Index Test")

# PetApply.create({pet: pet_1, apply: application_1})
# PetApply.create({pet: pet_2, apply: application_1})
# PetApply.create({pet: pet_2, apply: application_2})
# PetApply.create({pet: pet_3, apply: application_2})

review_1 = shelter_2.reviews.create(title: 'Amazing', rating: 5, content: 'Found my best friend', image: 'https://live.staticflickr.com/7396/8728178651_912c2fa554_b.jpg')
review_2 = shelter_2.reviews.create(title: 'Sucky', rating: 0, content: 'worst shelter ever. the manager yelled at me', image: 'https://www.peta.org/wp-content/uploads/2012/05/no-kill-gallery-03.jpg')
review_3 = shelter_1.reviews.create(title: 'Yay', rating: 4, content: 'Loved it; the staff was so nice', image: 'https://www.clickorlando.com/resizer/neh8Wa4LQMzrQXwjJbpF89AP-Ms=/640x360/smart/filters:format(jpeg):strip_exif(true):strip_icc(true):no_upscale(true):quality(65)/arc-anglerfish-arc2-prod-gmg.s3.amazonaws.com/public/QV4N6JPXXVFCHP4QRTZYSEJEOY.jpg')
review_4 = shelter_1.reviews.create(title: 'Best shelter eva', rating: 5, content: 'I see how much they are doing to keep the animals happy', image: 'https://pyxis.nymag.com/v1/imgs/4bf/7d0/53374ff9319d2ebca19ebb532b1cec2b1d-17-shelter.rsquare.w1200.jpg')
review_5 = shelter_2.reviews.create(title: 'Not the best', rating: 1, content: 'Not my favorite shelter, they only had pitbulls', image: 'https://www.citywatchla.com/images/stories/Sept-2017/075n.png')
