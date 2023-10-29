desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do

  # Destroying Preevious Data
  pp "Destroying Previous Data"

  if Rails.env.development?
    User.destroy_all
    Venue.destroy_all
    WeightClass.destroy_all
    Event.destroy_all
    Bout.destroy_all
    Message.destroy_all
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
    user.email = "#{row[0].split.at(0)}-#{row[0].split.at(1)}@mma.com"
    user.password = "password"
    user.username = row[0].gsub(/\s+/, '-').downcase
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

  ##Generating Bouts
  pp "Generating Bouts"

  users = User.all
  users.each do |first_user|
    users.each do |second_user|
      if rand < 0.10
        first_user.registered_bouts.create(
          blue_corner_id: rand < 0.50 ? second_user.id : nil,
          event_id: Event.all[rand(78)].id,
          weight_class_id: WeightClass.all[rand(13)].id
        )
      end

      # if rand < 0.75
      #   second_user.sent_follow_requests.create(
      #     recipient: first_user,
      #     status: FollowRequest.statuses.keys.sample
      #   )
      # end
    end
  end

  pp "There are now #{Bout.count} bouts."

  ##Generate Messages
  pp "Generating Messages"

  events = Event.all
  events.each do |event|
    5.times do
      sender1 = event.red_corner_fighters.all.sample
      sender1.messages.create(
        event_id = event.id,
        user_id = sender1.id,
        content = "oooooo"
      )
      sender2 = event.blue_corner_fighters.all.sample
      sender2.messages.create(
        event_id = event.id,
        user_id = sender2.id,
        content = "aaaaaa"
      )
    end
  end

  pp "There are now #{Message.count} messages."
end
