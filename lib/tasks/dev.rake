desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do
  api = "https://www.ufc.com/athletes/all?filters%5B0%5D=location%3AIE&filters%5B1%5D=location%3ARU&filters%5B2%5D=location%3AUS&filters%5B3%5D=status%3A23&filters%5B4%5D=weight_class%3A8&filters%5B5%5D=weight_class%3A9&filters%5B6%5D=weight_class%3A10&filters%5B7%5D=weight_class%3A11&filters%5B8%5D=weight_class%3A12&filters%5B9%5D=weight_class%3A13&filters%5B10%5D=weight_class%3A14&filters%5B11%5D=weight_class%3A15"
end
