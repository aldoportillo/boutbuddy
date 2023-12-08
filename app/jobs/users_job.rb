class UsersJob < ApplicationJob
  queue_as :default

  def perform
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
end
