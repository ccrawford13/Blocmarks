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

5.times do
  topic = Topic.new(
    title:         Faker::Lorem.characters(15),
    user:          users.sample
  )
  topic.save!
end

topics = Topic.all

urls = ['http://stackoverflow.com/', 'https://plus.google.com/u/0/', 'http://embed.ly/docs/products/cards', 'http://google.com/videos', 'http://html2haml.herokuapp.com/', 
        'http://foundation.zurb.com/docs/', 'http://felixclack.com/', 'https://www.youtube.com/watch?v=xQJ-QGYrpRc', 'https://www.youtube.com/watch?v=bmzSy2JHmuA', 'https://www.youtube.com/watch?v=Vclo2wVDBvE',
        'https://stocksnap.io/', 'https://www.bloc.io/' ]

35.times do
  bookmark = Bookmark.new(
    description:  Faker::Lorem.characters(15),
    url:          urls.sample,
    topic:        topics.sample,
    user:         users.sample
  )
  bookmark.save!
end

bookmarks = Bookmark.all

30.times do
  like = Like.new(
    user:         users.sample,
    bookmark:     bookmarks.sample
  )
  like.save!
end

likes = Like.all

puts "Created #{User.count} users"
puts "Created #{Topic.count} topics"
puts "Created #{Bookmark.count} bookmarks"
puts "Created #{Like.count} likes"