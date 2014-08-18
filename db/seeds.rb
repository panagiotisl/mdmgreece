# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
admin = User.create(:email => 'mike@madgik.gr', :password => 'foobar23', :password_confirmation => 'foobar23', :approved => true)
user = User.create(:email => 'scottie@madgik.gr', :password => 'foobar33', :password_confirmation => 'foobar33', :approved => false)
