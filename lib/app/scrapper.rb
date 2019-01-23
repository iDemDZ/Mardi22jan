require 'open-uri'
require 'nokogiri'

class Scrapper

  def get_townhall_urls
    urls_townhall = []

    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    doc.xpath('//*[@class="lientxt"]').each { |ele| urls_townhall << ele.values[1] }

    return urls_townhall.each { |url| url.delete_prefix!(".").insert(0, 'http://annuaire-des-mairies.com') }
  end



  def emails_townhall
    emails_townhall = []
    n = 0

    (get_townhall_urls.length).times do
    doc = Nokogiri::HTML(open(get_townhall_urls[n]))
    doc.xpath('/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]').each { |email| emails_townhall << email.text }      
    n += 1
    end
    return emails_townhall
  end



  def names_townhall
    names_townhall = []
    doc = Nokogiri::HTML(open("http://annuaire-des-mairies.com/val-d-oise.html"))
    doc.xpath('//*[@class="lientxt"]').each { |ele| names_townhall << ele.text }
    return names_townhall
  end



  def perform
    names = names_townhall
    emails = emails_townhall

    Hash[names.zip(emails)]
  end

end
