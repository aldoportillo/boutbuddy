# to enuqueue: FightersJob.perform_later
# to run: bundle exec good_job start 
class FightersJob < ApplicationJob
  queue_as :default

  def perform(*args)
    
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
  end    


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
end
