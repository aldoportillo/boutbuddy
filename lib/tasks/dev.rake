require "faker"

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

  user = User.new
  user.id = 1
  user.first_name = "null"
  user.last_name = "null"
  user.reach = 100
  user.height = 100
  user.weight = 100
  user.email = "nullnull@mma.com"
  user.password = "password"
  user.username = "nullnull"
  user.photo_url = "https://www.littleglassjar.com/wp-content/uploads/2014/11/deer-head-silhouette.jpg"
  user.role = "undetermined"
  user.save

  CSV.foreach('lib/sample_data/athletes_metrics.csv', :headers => true) do |row|
    user = User.new
    user.first_name = row[0].split.at(0)
    user.last_name = row[0].split.at(1)
    user.photo_url = row[1]
    user.reach = row[3]
    user.height = row[4]
    user.weight = row[5]
    user.email = "#{row[0].split.at(0)}-#{row[0].split.at(1)}@mma.com"
    user.role = row[6]
    user.password = "password"
    user.username = row[0].gsub(/\s+/, '-').downcase
    user.save
  end

  user = User.new
  user.first_name = "Cage"
  user.last_name = "Rage"
  user.reach = 100
  user.height = 100
  user.weight = 100
  user.email = "cage-rage@mma.com"
  user.password = "password"
  user.username = "cage-rage"
  user.photo_url = "https://media.bleacherreport.com/w_800,h_533,c_fill/br-img-slides/003/667/027/6ac3bb5e647003418405493cdcf3ae61_crop_exact.jpg"
  user.role = "promoter"
  user.save

  user = User.new
  user.first_name = "King"
  user.last_name = "Cage"
  user.reach = 100
  user.height = 100
  user.weight = 100
  user.email = "king-cage@mma.com"
  user.password = "password"
  user.username = "king-cage"
  user.photo_url = "https://media.bleacherreport.com/w_800,h_533,c_fill/br-img-slides/003/667/028/440a28f3a80ff916053d2d3d1ce22f0c_crop_exact.jpg"
  user.role = "promoter"
  user.save

  user = User.new
  user.first_name = "bella"
  user.last_name = "tor"
  user.reach = 100
  user.height = 100
  user.weight = 100
  user.email = "bellator@mma.com"
  user.password = "password"
  user.username = "bellator"
  user.photo_url = "https://media.bleacherreport.com/w_800,h_533,c_fill/br-img-slides/003/667/031/61a46750e6d1fc750ccdfd814d02d5ec_crop_exact.jpg"
  user.role = "promoter"
  user.save

  user = User.new
  user.first_name = "strike"
  user.last_name = "force"
  user.reach = 100
  user.height = 100
  user.weight = 100
  user.email = "strike-force@mma.com"
  user.password = "password"
  user.username = "strike-force"
  user.photo_url = "https://media.bleacherreport.com/w_800,h_533,c_fill/br-img-slides/003/667/032/1798cc866e656bfb7d7a196f16f4de86_crop_exact.jpg"
  user.role = "promoter"
  user.save

  user = User.new
  user.first_name = "one"
  user.last_name = "fc"
  user.reach = 100
  user.height = 100
  user.weight = 100
  user.email = "one-fc@mma.com"
  user.password = "password"
  user.username = "one-fc"
  user.photo_url = "https://mma.prnewswire.com/media/814161/ONE_Championship_black_logo_sq_Logo.jpg?p=facebook"
  user.role = "promoter"
  user.save
  pp "There are now #{User.count} users."

  # Generating Venues
  pp "Generating Venues"

  CSV.foreach('lib/sample_data/venues.csv', :headers => true) do |row|
    venue = Venue.new
    venue.name = row[1]
    venue.lat = row[8]
    venue.lng = row[9]
    venue.address = row[7]
    venue.promoter_id = User.where(:role => "promoter").sample.id
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
    event.venue_id = Venue.all.sample.id
    event.promoter_id = User.where(:role => "promoter").sample.id
    event.save!
  end

  pp "There are now #{Event.count} events."

  ##Generating Bouts
  pp "Generating Bouts"

  users = User.all
  users.each do |first_user|
    if first_user.id != 1
      users.each do |second_user|
        if rand < 0.10
          first_user.registered_bouts.create(
            blue_corner_id: rand < 0.50 ? second_user.id : 1,
            event_id: Event.all.sample.id,
            weight_class_id: WeightClass.all.sample.id
          )
        end
      end
    end
  end

  pp "There are now #{Bout.count} bouts."

  ##Generate Messages
  pp "Generating Messages"

  events = Event.all
  
  events.each do |event|

    event.red_corner_fighters.each do |fighter|
      if fighter.id != 1
        fighter.messages.create(event_id: event.id, user_id: fighter.id, content: Faker::Quote.most_interesting_man_in_the_world )
      end
    end
    event.blue_corner_fighters.each do |fighter|
      if fighter.id != 1
        fighter.messages.create(event_id: event.id, user_id: fighter.id, content: Faker::Quote.most_interesting_man_in_the_world )
      end
    end
  end

  pp "There are now #{Message.count} messages."
end
