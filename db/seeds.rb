# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Url.create([
  { 
    internal: "syfd34kv", 
    external: "http://www.google.co.uk"
  },
  { 
    internal: "snfr48hs",
    external: "http://www.yahoo.co.uk"
  },
  { 
    internal: "sdar16kw",
    external: "http://www.bing.com"
  }
])
