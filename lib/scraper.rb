require 'open-uri'
require "nokogiri"
require 'pry'
require_relative './student.rb'


class Scraper

  def self.scrape_index_page(index_url)
        html = open(index_url)
        studentpage=Nokogiri::HTML(html)
        #res= studentpage.css("body > div > div > div.roster-cards-container")
        res= studentpage.css(".student-card")
         #binding.pry
         hash = res.map do |i|
          {
              name: i.css("h4").text ,
              location: i.css("p").text ,
              profile_url: i.css('a').attribute('href').value
          }
         end
        hash
  end

  def self.scrape_profile_page(profile_url)
      html = open(profile_url)
      studentpage=Nokogiri::HTML(html)
      arr=[]
      social = studentpage.css("div.social-icon-container a")
      hash={}
  social.each do |child|
      value  = child.attribute('href').value
  if value.include? "linkedin"
      hash[:linkedin] = value
  elsif  value.include? "github"
     hash[:github] =  value
  elsif  value.include? "twitter"
     hash[:twitter] = value
   else
        hash[:blog] =  value
  end

 end
    hash[:bio] = studentpage.css("body > div > div.details-container > div.bio-block.details-block > div > div.description-holder > p").text
    hash[:profile_quote] = studentpage.css("body > div > div.vitals-container > div.vitals-text-container > div").text
    hash
  end

end
