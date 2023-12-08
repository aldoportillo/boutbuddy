class BoutsJob < ApplicationJob
  queue_as :default

  def perform
    pp "Generating Bouts"
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
  end
end
