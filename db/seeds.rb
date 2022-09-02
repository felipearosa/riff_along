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

10.times do |i|
  i += 1
  List.create(name: 'Reggae', description: 'My reggae list i want to learn', user_id: i)
  List.create(name: 'Pop', description: 'My pop songs, thats all. Shithead', user_id: i)
  List.create(name: 'Indie', description: 'Not emo, indie. Just indie. And hate.', user_id: i)
  List.create(name: 'Brega', description: 'List to feed my soul and grow mullets.', user_id: i)
  List.create(name: 'Solos', description: 'My favorite solos songs', user_id: i)
end

Video.create(youtube_key: '20Ov0cDPZy8', title: "John Mayer - Free Fallin' (Live at the Nokia Theatre)", image_url: 'https://i.ytimg.com/vi/20Ov0cDPZy8/hqdefault.jpg')
Video.create(youtube_key: 'obkrMiyDrbs', title: "Alicia Keys & John Mayer - If I ain't got you - Gravity (Better audio quality)", image_url: 'https://i.ytimg.com/vi/obkrMiyDrbs/hqdefault.jpg')
Video.create(youtube_key: 'iK8mD_qA3lQ', title: "John Mayer Greatest Hits -John Mayer Full Album 2021", image_url: 'https://i.ytimg.com/vi/iK8mD_qA3lQ/hqdefault.jpg')
Video.create(youtube_key: 'bpZvg_FjL3Q', title: "Bob Dylan - Hurricane (Official Audio)", image_url: 'https://i.ytimg.com/vi/bpZvg_FjL3Q/hqdefault.jpg')
Video.create(youtube_key: 'kHjzuqq3b44', title: "Bob Dylan Greatest Hits - Best Songs of Bob Dylan (HQ)", image_url: 'https://i.ytimg.com/vi/kHjzuqq3b44/hqdefault.jpg')
Video.create(youtube_key: 'MMFj8uDubsE', title: "Bob Dylan - Blowin' in the Wind (Official Audio)", image_url: 'https://i.ytimg.com/vi/MMFj8uDubsE/hqdefault.jpg')
Video.create(youtube_key: 'qFfnlYbFEiE', title: "The Jimi Hendrix Experience - Voodoo Child (Slight Return) (Live In Maui, 1970)", image_url: 'https://i.ytimg.com/vi/qFfnlYbFEiE/hqdefault.jpg')
Video.create(youtube_key: '6EOK8gPsGzo', title: "Jimi Hendrix greatest hits (full album) - Best songs of Jimi Hendrix {COOL MUSIC}", image_url: 'https://i.ytimg.com/vi/6EOK8gPsGzo/hqdefault.jpg')
Video.create(youtube_key: 'iaE4s3m8UOQ', title: "The Jimi Hendrix Experience - Little Wing [Legendado/Tradução]", image_url: 'https://i.ytimg.com/vi/iaE4s3m8UOQ/hqdefault.jpg')
Video.create(youtube_key: 'rdi7G1hY4-w', title: "Its My Life | Sri Lankan Version | Sandaru Sathsara", image_url: 'https://i.ytimg.com/vi/rdi7G1hY4-w/hqdefault.jpg')

50.times do |i|
  i += 1
  Catalog.create(list_id: i, video_id: 1)
  Catalog.create(list_id: i, video_id: 2)
  Catalog.create(list_id: i, video_id: 3)
  Catalog.create(list_id: i, video_id: 4)
  Catalog.create(list_id: i, video_id: 5)
  Catalog.create(list_id: i, video_id: 6)
  Catalog.create(list_id: i, video_id: 7)
  Catalog.create(list_id: i, video_id: 8)
  Catalog.create(list_id: i, video_id: 9)
  Catalog.create(list_id: i, video_id: 10)
end

puts "Seeding done. Finally."
