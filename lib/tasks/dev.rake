desc "Fill the database tables with some sample data"
task({ :sample_data => :environment }) do

  # Destroying Preevious Data
  pp "Destroying Previous Data"

  if Rails.env.development?
    User.destroy_all
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

end
