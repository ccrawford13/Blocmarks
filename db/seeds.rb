require 'faker'

admin = User.new(
  first_name:                'admin',
  last_name:                 'istrator',
  email:                     'chad@example.com',
  password:                  'password',
  password_confirmation:     'password'
  )
admin.skip_confirmation!
admin.save!

admin2 = User.new(
  first_name:                'Tom',
  last_name:                 'Jones',
  email:                     'tom@example.com',
  password:                  'password',
  password_confirmation:     'password'
  )
admin2.skip_confirmation!
admin2.save!

users = User.all

25.times do
  topic = Topic.new(
    title:         Faker::Lorem.sentence,
    user:          users.sample
  )
  topic.save
end

topics = Topic.all

50.times do
  bookmark = Bookmark.new(
    description:  Faker::Lorem.sentence(2),
    url:          Faker::Internet.url,
    topic:        topics.sample
  )
  bookmark.save
end