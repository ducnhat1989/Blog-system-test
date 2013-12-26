namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_entries
    make_commnent_entry
    make_relationships
  end
end

def make_users
  admin = User.create!(name:     "Framgia",
                       email:    "admin@framgia.com",
                       password: "123456",
                       password_confirmation: "123456")
  99.times do |n|
    name  = Faker::Name.name
    email = "example-#{n+1}@framgia.com"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end
end

def make_entries
  users = User.all(limit: 6)
  50.times do
    title = Faker::Lorem.sentence(1)
    body = Faker::Lorem.sentence(30)
    users.each { |user| user.entries.create!(title: title, body: body) }
  end
end

def make_commnent_entry
    entries = Entry.all(limit: 10)
    user1 = User.find(1)
    user2 = User.find(2)
    5.times do
      content = Faker::Lorem.sentence(2)
      entries.each { |entry| entry.comments.create!(content: content, user_id:user1.id) }
    end
    5.times do
      content = Faker::Lorem.sentence(2)
      entries.each { |entry| entry.comments.create!(content: content, user_id:user2.id) }
    end
end

def make_relationships
  users = User.all
  user  = users.first
  followed_users = users[2..50]
  followers      = users[3..40]
  followed_users.each { |followed| user.follow!(followed) }
  followers.each      { |follower| follower.follow!(user) }
end