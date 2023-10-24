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

desc "Scrape Athlete Metric Data"
task({ :scrape_athlete_metrics => :environment }) do

  #Get the slugs from CSV
  slugs = CSV.read('lib/sample_data/athletes.csv').map { |row| row.at(1) }

  #Make a request to the URL with each slug
  raw_responses = slugs.map { |slug| HTTP.get("https://www.ufc.com/athlete/#{slug}") }
  documents = raw_responses.map { |response| Nokogiri::HTML(response.to_s) }

  #Scrape Data
  fighters_data = documents.map do |doc|
    image_element = doc.at('img.hero-profile__image')
    image_src = image_element ? image_element.attr('src') : nil

    {
      :name => doc.css('.hero-profile__name').text.strip,
      :image_src => image_src,
      :age => doc.at('div:contains("Age") > .c-bio__text')&.text&.strip,
      :reach => doc.at('div:contains("Reach") > .c-bio__text')&.text&.strip,
      :height => doc.at('div:contains("Height") > .c-bio__text')&.text&.strip,
      :weight => doc.at('div:contains("Weight") > .c-bio__text')&.text&.strip,
    }
  end
  
  # Save in csv
  CSV.open('lib/sample_data/athletes_metrics.csv', 'a+') do |csv|
    existing = csv.entries
    fighters_data.each do |fighter|
      unless existing.include?([fighter[:name], fighter[:image_src], fighter[:age], fighter[:reach], fighter[:height], fighter[:weight]])
        csv << [fighter[:name], fighter[:image_src], fighter[:age], fighter[:reach], fighter[:height], fighter[:weight]]
      end
    end
  end

  #Print outcome
  puts "Collected new data for #{fighters_data.count} fighters"
end
