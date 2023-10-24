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

  CSV.open('lib/sample_data/athletes.csv', 'a+') do |csv|
    
    existing = csv.entries

    fighter_names.each do |name|
      pp name
      slug = name.text.gsub(/\s+/, '-').downcase
      unless existing.include?([name, slug])
        csv << [name, slug]
      end
    end

    puts "Found #{fighter_names.count} new fighters"
  end
  
end

  # Later
  ## URL: fighter_url = "https://www.ufc.com/athlete/#{format_name}"
  ## Name class: .css(".hero-profile__name").text
  ## Potential Fix to my issue: parsed_page.css(".c-bio__text").flat_map(&:classes)
