require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    student_hash = []
    index_page.css(".roster-cards-container").each do |card|
      card.css("a").each do |info|
        student_name = info.css(".student-name").text
        student_location = info.css(".student-location").text
        student_url = "#{info.attr('href')}"

        student_hash << {:name => student_name, :location => student_location, :profile_url => student_url}
      end
    end
    student_hash
  end

  def self.scrape_profile_page(profile_url)
     doc = Nokogiri::HTML(open(profile_url))
        student_quote = doc.css("div.profile-quote").text
        student_bio = doc.css(".description-holder p").text  
         student = {}
        doc.css(".social-icon-container a").each do |account| 
          social_media_account = account.attr("href")
           if social_media_account.include?("twitter") 
             student_twitter = social_media_account  
             student_twitter ? student[:twitter] = student_twitter : student[:twitter] = nil
           elsif social_media_account.include?("github")
             student_github = social_media_account
             student_github ? student[:github] = student_github : student[:github] = nil
           elsif social_media_account.include?("linkedin")
             student_linkedin = social_media_account
             student_linkedin ? student[:linkedin] = student_linkedin : student[:linkedin] = nil
           else 
               student_blog = social_media_account
               student_blog ? student[:blog] = student_blog : student[:blog] = nil
           end
        end
            student_bio ? student[:bio] = student_bio : student[:bio] = nil
           student_quote ? student[:profile_quote] = student_quote : student[:profile_quote] = nil
         student
    end

end

