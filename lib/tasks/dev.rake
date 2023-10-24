require "http"
require "nokogiri"
desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  # url = "https://www.ufc.com/athletes/all?filters%5B0%5D=location%3AIE&filters%5B1%5D=location%3ARU&filters%5B2%5D=location%3AUS&filters%5B3%5D=status%3A23&filters%5B4%5D=weight_class%3A8&filters%5B5%5D=weight_class%3A9&filters%5B6%5D=weight_class%3A10&filters%5B7%5D=weight_class%3A11&filters%5B8%5D=weight_class%3A12&filters%5B9%5D=weight_class%3A13&filters%5B10%5D=weight_class%3A14&filters%5B11%5D=weight_class%3A15"

  url = "https://www.bt.com/sport/ufc/fighters"

  webpage_as_s = HTTP.get(url).body.to_s
  parsed_page = Nokogiri::HTML(webpage_as_s)

  names = parsed_page.css(".item-title")

  counter = 0
  names.each do |name|
    pp name.text.gsub(/\s+/, '-').downcase
    counter += 1
  end

  pp counter
end
