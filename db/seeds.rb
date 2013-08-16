# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u1 = User.create(firstname: "hans", lastname: "Peter", email: "hans@peter.de", password: "12345678", password_confirmation: "12345678")
u2 = User.create(firstname: "susi", lastname: "Peter", email: "susi@peter.de", password: "12345678", password_confirmation: "12345678")
u3 = User.create(firstname: "michi", lastname: "Peter", email: "michi@peter.de", password: "12345678", password_confirmation: "12345678")

u1.friends << u2
u1.friends << u3
u2.friends << u1
u2.friends << u3
