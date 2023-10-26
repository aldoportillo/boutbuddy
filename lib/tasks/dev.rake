desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do

  # Destroying Preevious Data
  pp "Destroying Previous Data"

  if Rails.env.development?
    User.destroy_all
    Venue.destroy_all
    WeightClass.destroy_all
    Event.destroy_all
  end

  # Generate Users
  pp "Generating Users"

  CSV.foreach('lib/sample_data/athletes_metrics.csv', :headers => true) do |row|
    user = User.new
    user.first_name = row[0].split.at(0)
    user.last_name = row[0].split.at(1)
    user.photo_url = row[1]
    user.reach = row[3]
    user.height = row[4]
    user.weight = row[5]
    user.email = "#{row[0].split.at(0)}-#{row[0].split.at(1)}@example.com"
    user.password = "password"
    user.save
  end

  pp "There are now #{User.count} users."

  # Generating Venues
  pp "Generating Venues"

  CSV.foreach('lib/sample_data/venues.csv', :headers => true) do |row|
    venue = Venue.new
    venue.name = row[1]
    venue.lat = row[8]
    venue.lng = row[9]
    venue.address = row[7]
    venue.save
  end

  pp "There are now #{Venue.count} venues."

  # Generating Weight Classes
  pp "Generating Weight Classes"

  #Might need to generate this first to I can add a weight class ID to user that takes user's weight to get weight class
  CSV.foreach('lib/sample_data/weight_classes.csv', :headers => true) do |row|
    weight_class = WeightClass.new
    weight_class.name = row.fetch("name")
    weight_class.max = row.fetch("max")
    weight_class.min = row.fetch("min")
    weight_class.save
  end

  pp "There are now #{WeightClass.count} weight classes."
  
  #Generating Events
  pp "Generating Events"

  
  CSV.foreach('lib/sample_data/events.csv', :headers => true) do |row|
    event = Event.new
    event.title = row[0]
    event.bio = row[1]
    event.time = rand(2.years).seconds.from_now
    event.price = rand(15..45)
    event.venue_id = Venue.all.at(rand(1..99)).id
    event.save
  end

  pp "There are now #{Event.count} events."

end
