# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)
puts "Seeding..."

User.create(first_name: 'One', last_name: 'OneOne', email: 'test@test.com', password: '123123', password_confirmation: '123123')
User.create(first_name: 'Two', last_name: 'TwoTwo', email: 'test2@test.com', password: '123123', password_confirmation: '123123')
User.create(first_name: 'Three', last_name: 'ThreeThree', email: 'test3@test.com', password: '123123', password_confirmation: '123123')
User.create(first_name: 'Four', last_name: 'FourFour', email: 'test4@test.com', password: '123123', password_confirmation: '123123')
User.create(first_name: 'Five', last_name: 'FiveFive', email: 'test5@test.com', password: '123123', password_confirmation: '123123')
User.create(first_name: 'Six', last_name: 'SixSix', email: 'test6@test.com', password: '123123', password_confirmation: '123123')
User.create(first_name: 'Seven', last_name: 'SevenSeven', email: 'test7@test.com', password: '123123', password_confirmation: '123123')
User.create(first_name: 'Eight', last_name: 'EightEight', email: 'test8@test.com', password: '123123', password_confirmation: '123123')
User.create(first_name: 'Nine', last_name: 'NineNine', email: 'test9@test.com', password: '123123', password_confirmation: '123123')
User.create(first_name: 'Ten', last_name: 'TenTen', email: 'test10@test.com', password: '123123', password_confirmation: '123123')

List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: 1)
List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: 1)
List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: 1)
List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: 1)
List.create(name: 'Solos', description: 'My favorite solos songs', user_id: 1)

List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: 2)
List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: 2)
List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: 2)
List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: 2)
List.create(name: 'Solos', description: 'My favorite solos songs', user_id: 2)

List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: 3)
List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: 3)
List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: 3)
List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: 3)
List.create(name: 'Solos', description: 'My favorite solos songs', user_id: 3)

List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: 4)
List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: 4)
List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: 4)
List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: 4)
List.create(name: 'Solos', description: 'My favorite solos songs', user_id: 4)

List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: 5)
List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: 5)
List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: 5)
List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: 5)
List.create(name: 'Solos', description: 'My favorite solos songs', user_id: 5)

List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: 6)
List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: 6)
List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: 6)
List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: 6)
List.create(name: 'Solos', description: 'My favorite solos songs', user_id: 6)

List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: 7)
List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: 7)
List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: 7)
List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: 7)
List.create(name: 'Solos', description: 'My favorite solos songs', user_id: 7)

List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: 8)
List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: 8)
List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: 8)
List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: 8)
List.create(name: 'Solos', description: 'My favorite solos songs', user_id: 8)

List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: 9)
List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: 9)
List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: 9)
List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: 9)
List.create(name: 'Solos', description: 'My favorite solos songs', user_id: 9)

List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: 10)
List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: 10)
List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: 10)
List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: 10)
List.create(name: 'Solos', description: 'My favorite solos songs', user_id: 10)

Video.create(youtube_key: '20Ov0cDPZy8')
Video.create(youtube_key: 'obkrMiyDrbs')
Video.create(youtube_key: 'iK8mD_qA3lQ')
Video.create(youtube_key: 'bpZvg_FjL3Q')
Video.create(youtube_key: 'kHjzuqq3b44')
Video.create(youtube_key: 'MMFj8uDubsE')
Video.create(youtube_key: 'qFfnlYbFEiE')
Video.create(youtube_key: '6EOK8gPsGzo')
Video.create(youtube_key: 'iaE4s3m8UOQ')
Video.create(youtube_key: 'rdi7G1hY4-w')

Catalog.create()

puts "Seeding done. Finally."
