require 'json'
require_relative './scrapper'

tempHash = Scrapper.new.perform

File.open("db/email.json","w") do |f|
    f.write(JSON.pretty_generate(tempHash))
end