class WinByJob < ApplicationJob
  queue_as :default

  def perform
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
end
