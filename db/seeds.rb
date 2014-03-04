# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Create the super_admin account explicitly
User.create(name: 'super_admin',
            email: 'super_admin@backchannel.com',
            password: 'super_admin',
            password_confirmation: 'super_admin',
            user_level: 3)

admins = [
    {name: 'admin',
     email: 'admin@backchannel.com',
     password: 'admin',
     password_confirmation: 'admin',
     user_level: 2}
]

users = [
    {name: 'Marty McFly',
    email: 'backto@thefuture.com',
    password: 'marty',
    password_confirmation: 'marty',
    user_level: 1},
    {name: 'Mitchell Neville',
     email: 'mdnevill@ncsu.edu',
     password: 'mitchell',
     password_confirmation: 'mitchell',
     user_level: 1}
]

categories = [
    {approved: true,
     name: 'Science'},
    {approved: false,
      name: 'Biology'},
    {approved: true,
     name: 'History'}
]

admins.each{|admin| User.create admin}
users.each {|user| User.create user}
categories.each {|category| Category.create category}