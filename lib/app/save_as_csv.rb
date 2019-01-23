require 'csv'
require_relative './scrapper'

#création d'un array d'array à partir du hash du fichier scrapper.rb de type [[key, value],[key, value]...]
arr = Array.new
Scrapper.new.perform.each { |key, value| arr << [key, value]}

#convertion de l'array au format csv:
#key,value
#key,value
#...
format_csv = arr.map { |ele| ele.join(",")}.join("\n")

#creation d'un fichier emails.csv qui contient notre array converti au format csv dans le dossier db
system("touch db/emails.csv")
file = File.open("db/emails.csv", "w")
file.puts("#{format_csv}")
file.close