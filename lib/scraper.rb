require 'nokogiri'
require 'open-uri'
require 'pry'

require_relative './course.rb'

class Scraper
  
  def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    url="http://learn-co-curriculum.github.io/site-for-scraping/courses"
    doc= Nokogiri::HTML(URI.open(url))
  end

  def get_courses
    articles = self.get_page.css(".post")
    articles
  end

  def make_courses
    self.get_courses.each do|article|
      course = Course.new
      course.title= article.css("h2").text
      course.description = article.css("p").text
      course.schedule = article.css(".date").text
    end
  end
end

Scraper.new.get_page




