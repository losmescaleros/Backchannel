# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(name: 'super_admin',
            email: 'super_admin@backchannel.com',
            password: 'super_admin',
            password_confirmation: 'super_admin',
            user_level: 3)

User.create(name: 'Marty McFly',
            email: 'backto@thefuture.com',
            password: 'marty',
            password_confirmation: 'marty',
            user_level: 1)

User.create(name: 'Mitchell Neville',
            email: 'mdnevill@ncsu.edu',
            password: 'mitchell',
            password_confirmation: 'mitchell',
            user_level: 1)
