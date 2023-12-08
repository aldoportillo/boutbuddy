class VenuesJob < ApplicationJob
  queue_as :default

  def perform
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
  end
end
