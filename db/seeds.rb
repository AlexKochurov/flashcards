# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed
# (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'nokogiri'
require 'open-uri'


user = User.create(email: "user@example.com", password: "12345678",
                                              password_confirmation: "12345678")
b = user.blocks.create(title: "Top words")

doc = Nokogiri::HTML(open('https://www.learnathome.ru/blog/100-beautiful-words'))

doc.search('//table/tbody/tr').each do |row|
  original = row.search('td')[1].content.downcase
  translated = row.search('td')[3].content.downcase
  user.cards.create(original_text: original, translated_text: translated,
                    block_id: b.id)
end