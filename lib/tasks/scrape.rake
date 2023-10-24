require "http"
require "nokogiri"
require "csv"

desc "Scrape Athlete Data"
task({ :scrape_athlete_names => :environment }) do

  # go to this url https://www.bt.com/sport/ufc/fighters
  # scrape fighters names
  # format names
  # open lib/sample_data/athletes.csv
    # create if not exists
  # append fighter (name, slug) (if not existing)
  # save file
  # output results to console
    # found 100 new fighters

  fighters_raw_response = HTTP.get("https://www.bt.com/sport/ufc/fighters").body.to_s
  fighers_parsed_page = Nokogiri::HTML(fighters_raw_response)

  fighter_names = fighers_parsed_page.css(".item-title").uniq.slice(0, 100)

  counter = 0

  fighter_data = []
  fighter_names.each do |name|

    format_name = name.text.gsub(/\s+/, '-').downcase

    fighter_url = "https://www.ufc.com/athlete/#{format_name}"

    webpage_as_s = HTTP.get(fighter_url).body.to_s
    parsed_page = Nokogiri::HTML(webpage_as_s)

    fighter_name = parsed_page.css(".hero-profile__name").text

    
    if fighter_name != ""
      pp fighter_name
      pp parsed_page.css(".c-bio__text").flat_map(&:classes)
    end

    counter += 1
  end

  pp counter
  
end
