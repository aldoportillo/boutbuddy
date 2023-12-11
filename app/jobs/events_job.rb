class EventsJob < ApplicationJob
  queue_as :default

  def perform
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
  end
end
