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
    #  res = studentpage.css("body div.main-wrapper profile")
    hash =
     {

   linkedin:  studentpage.css('body > div > div.vitals-container > div.social-icon-container > a:nth-child(2)').attribute('href').value,
   github: studentpage.css('body > div > div.vitals-container > div.social-icon-container > a:nth-child(3)').attribute('href').value,
   blog: 
   bio: studentpage.css("body > div > div.details-container > div.bio-block.details-block > div > div.description-holder > p").text,
   profile_quote: studentpage.css("body > div > div.vitals-container > div.vitals-text-container > div").text,
   twitter: studentpage.css("body > div > div.vitals-container > div.social-icon-container > a:nth-child(1)").attribute('href').value
     }


  end


end
#https://learn-co-curriculum.github.io/student-scraper-test-page/students/ryan-johnson.html
#https://learn-co-curriculum.github.io/student-scraper-test-page/students/eric-an.html
#html="https://learn-co-curriculum.github.io/student-scraper-test-page/"
#binding.pry
