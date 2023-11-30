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
    Result.destroy_all
    Bout.destroy_all
    Message.destroy_all
    Swipe.destroy_all
    WinBy.destroy_all
  end


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


  # Generate Users
  pp "Generating Users"

  CSV.foreach('lib/sample_data/athletes_metrics.csv', :headers => true) do |row|
    user = User.new
    user.first_name = row[0].split.at(0)
    user.last_name = row[0].split.at(1)
    user.photo = row[1]
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
  user.photo = "https://media.bleacherreport.com/w_800,h_533,c_fill/br-img-slides/003/667/027/6ac3bb5e647003418405493cdcf3ae61_crop_exact.jpg"
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
  user.photo = "https://media.bleacherreport.com/w_800,h_533,c_fill/br-img-slides/003/667/028/440a28f3a80ff916053d2d3d1ce22f0c_crop_exact.jpg"
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
  user.photo = "https://media.bleacherreport.com/w_800,h_533,c_fill/br-img-slides/003/667/031/61a46750e6d1fc750ccdfd814d02d5ec_crop_exact.jpg"
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
  user.photo = "https://media.bleacherreport.com/w_800,h_533,c_fill/br-img-slides/003/667/032/1798cc866e656bfb7d7a196f16f4de86_crop_exact.jpg"
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
  user.photo = "https://mma.prnewswire.com/media/814161/ONE_Championship_black_logo_sq_Logo.jpg?p=facebook"
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
  
  #Generating Events
  pp "Generating Events"

  event_images = ["https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588433/boutbuddy/assets/sample_data/events/ih0zlyin1eeejnmrgkro.avif", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588433/boutbuddy/assets/sample_data/events/yram0bszpcbpsl5d8dbd.avif", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588433/boutbuddy/assets/sample_data/events/eogw5jzi7n5vhitynsud.avif", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588433/boutbuddy/assets/sample_data/events/gufe40oyt6nmxuyaoacz.avif", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588433/boutbuddy/assets/sample_data/events/txbblmo0km5crmkt63cm.avif", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588434/boutbuddy/assets/sample_data/events/vxqpsqtld01yjcr0dmig.webp", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588434/boutbuddy/assets/sample_data/events/lk2bnpgpg7vrktekexjn.webp", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588434/boutbuddy/assets/sample_data/events/bvpwhmpxqwpyid6hzdsd.avif", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588434/boutbuddy/assets/sample_data/events/x6lannsujim4tjp4oy5v.webp", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588434/boutbuddy/assets/sample_data/events/nxji0ggih8bun9ydyvwb.avif", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588435/boutbuddy/assets/sample_data/events/my2cl5iujy0mxyqb17lq.avif", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588435/boutbuddy/assets/sample_data/events/yvbl3cw8bp9ke4nxiwsa.jpg", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588435/boutbuddy/assets/sample_data/events/c1zfnbxqjztw6wr2uczn.avif", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588436/boutbuddy/assets/sample_data/events/momqburgtk69i8ixitrn.webp", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588436/boutbuddy/assets/sample_data/events/w69w8nzu9pgfzr9iozxk.avif", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588436/boutbuddy/assets/sample_data/events/xr81mmxoxtwlalysoqv4.webp", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588436/boutbuddy/assets/sample_data/events/sdmnf3uxdv4cdrlxwbqk.webp", "https://res.cloudinary.com/dkhtrg1ts/image/upload/v1700588436/boutbuddy/assets/sample_data/events/ritmdug4ygfdmk5zkmac.avif"]

  CSV.foreach('lib/sample_data/events.csv', :headers => true) do |row|
    event = Event.new
    event.title = "#{row[0]} #2"
    event.bio = row[1]
    event.time = rand(2.years).seconds.from_now
    event.price = rand(15..45)
    event.venue_id = Venue.all.sample.id
    event.photo = event_images.sample
    event.promoter_id = User.where(:role => "promoter").sample.id
    event.save!
  end

  pp "There are now #{Event.count} events."

  #Generating Swipes
  pp "Generating Swipes"

  User.find_each do |user|

    eligible_users = User.where(weight_class_id: user.weight_class_id).where.not(id: user.id)

    eligible_users.find_each do |other_user|
      if rand < 0.25
        Swipe.create!(
          swiper_id: user.id,
          swiped_id: other_user.id,
          like: true
          # like: [true, false].sample 
        )
      end
    end
  end

  pp "There are now #{Swipe.count} swipes"

  pp "Generating Bouts"
  
# Initialize a variable to keep track of the current event and the number of bouts assigned to it
current_event = Event.where("time > ?", Time.now).order(:time).first
bouts_per_event = Hash.new(0)

Swipe.where(like: true).find_each do |swipe|
  if Swipe.exists?(swiper_id: swipe.swiped_id, swiped_id: swipe.swiper_id, like: true)
    existing_bouts = Bout.joins(:participations).where(participations: { user_id: [swipe.swiper_id, swipe.swiped_id] })
    
    unless existing_bouts.exists?
      # Check if the current event has reached the limit of 12 bouts
      if bouts_per_event[current_event.id] >= 12
        # Move to the next soonest future event
        current_event = Event.where("time > ?", current_event.time).order(:time).first
      end

      # Check if there is a valid future event
      if current_event
        bout = Bout.create!(
          event: current_event,
          weight_class_id: User.find(swipe.swiper_id).weight_class_id
        )
    
        if bout.persisted?
          Participation.create!(bout: bout, user_id: swipe.swiper_id, corner: 'red')
          Participation.create!(bout: bout, user_id: swipe.swiped_id, corner: 'blue')

          # Increment the bout count for this event
          bouts_per_event[current_event.id] += 1
        end
      end
    end
  end
end

    pp "There are now #{Bout.count} Bouts"


  ##Generate Messages
  pp "Generating Messages"

  events = Event.all

  events.each do |event|
    participating_users = User.joins(:participations).where(participations: { bout: event.bouts }).distinct
    participating_users.each do |user|
      Message.create!(
        user: user,
        event: event,
        content: Faker::Quote.most_interesting_man_in_the_world
      )
    end
  end

  pp "There are now #{Message.count} messages."

  ##Generate Messages
  pp "Generate Win By"

  CSV.foreach('lib/sample_data/wins_by.csv', :headers => true) do |row|
    win_by = WinBy.new
    win_by.id = row[0]
    win_by.name = row[1]
    win_by.description = row[2]
    win_by.save
  end

  pp "There are now #{WinBy.count} methods of winning."


  # Generating 3 Past Events
  prev_ev = Event.count
  prev_swipe = Swipe.count
  prev_bout = Bout.count

  csv_rows = CSV.read('lib/sample_data/events.csv', headers: true).to_a
  selected_rows = csv_rows.sample(3) 

  selected_rows.each do |row|
    event = Event.new
    event.title = row[0]
    event.bio = row[1]
    event.time = rand(2.years).seconds.ago
    event.price = rand(15..45)
    event.venue_id = Venue.all.sample.id
    event.photo = event_images.sample
    event.promoter_id = User.where(role: 'promoter').sample.id
    event.save!
  end
  pp "#{Event.count - prev_ev} Past Events were generated"

  # Selecting 36 Fighters for Swipes (18 bouts, 2 fighters per bout)
  fighters = User.where(role: 'fighter').order("RANDOM()").first(36)

  # Generating Swipes
  fighters.each_slice(2) do |user1, user2|
    Swipe.create!(swiper_id: user1.id, swiped_id: user2.id, like: true)
    Swipe.create!(swiper_id: user2.id, swiped_id: user1.id, like: true)
  end
  pp "Swipes for #{Swipe.count - prev_swipe} bouts created"

  # Generating Bouts from Mutual Swipes
Swipe.where(like: true).find_each do |swipe|
  # Check for a mutual like
  if Swipe.exists?(swiper_id: swipe.swiped_id, swiped_id: swipe.swiper_id, like: true)
    existing_bouts = Bout.joins(:participations).where(participations: { user_id: [swipe.swiper_id, swipe.swiped_id] })
    
    # Proceed if no existing bout between these two fighters
    unless existing_bouts.exists?
      past_event = Event.where("time < ?", Time.now).order("RANDOM()").first

      if past_event
        bout = Bout.create!(event: past_event, weight_class_id: User.find(swipe.swiper_id).weight_class_id)

        if bout.persisted?
          Participation.create!(bout: bout, user_id: swipe.swiper_id, corner: 'red')
          Participation.create!(bout: bout, user_id: swipe.swiped_id, corner: 'blue')

          Result.create!(
            bout_id: bout.id,
            winner_id: [swipe.swiper_id, swipe.swiped_id].sample,
            win_by_id: WinBy.all.sample.id
          )

          [swipe.swiper_id, swipe.swiped_id].each do |fighter_id|
            Message.create!(user_id: fighter_id, event: past_event, content: Faker::Quote.most_interesting_man_in_the_world)
          end
        end
      else
        pp "No past events available for bouts"
      end
    end
  end
end
pp "#{Bout.count} Bouts with results and messages were generated"


end
