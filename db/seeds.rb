# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

TrackingType.find_or_create_by(description: "Once Daily", days:1)
TrackingType.find_or_create_by(description: "Once Weekly", days:7)
TrackingType.find_or_create_by(description: "Once Monthly", days:30)
TrackingType.find_or_create_by(description: "Once Annually", days: 365)
TrackingType.find_or_create_by(description: "One Time", days:30000)
