class WeightClassesJob < ApplicationJob
  queue_as :default
  
  def perform(*args)

     pp "Generating Weight Classes"

     CSV.foreach('lib/sample_data/weight_classes.csv', :headers => true) do |row|
       weight_class = WeightClass.new
       weight_class.name = row.fetch("name")
       weight_class.max = row.fetch("max")
       weight_class.min = row.fetch("min")
       weight_class.save
     end
   
     pp "There are now #{WeightClass.count} weight classes."
  end
end
