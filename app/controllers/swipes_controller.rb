class SwipesController < ApplicationController
  def create
    swipe = Swipe.new(swipe_params)
    if swipe.save
      check_for_match(swipe)
      # Handle response, e.g., render JSON
    else
      # Handle error
    end
  end

  private

  def swipe_params
    params.require(:swipe).permit(:swiper_id, :swiped_id, :like)
  end

  def check_for_match(swipe)
    if swipe.like
      if Swipe.exists?(swiper_id: swipe.swiped_id, swiped_id: swipe.swiper_id, like: true)
        create_bout(swipe)
      end
    end
  end

  def create_bout(swipe)
    bout = Bout.new(red_corner_id: swipe.swiper_id, blue_corner_id: swipe.swiped_id)
    
    bout.event = find_suitable_event
  
    if bout.save
      # Notify users or promoters about the new bout
      # ...
    else
      # Handle error
    end
  end

  def find_suitable_event
    
    Event.find_by_sql(<<-SQL).first
      SELECT events.*
      FROM events
      LEFT JOIN bouts ON bouts.event_id = events.id
      GROUP BY events.id
      HAVING COUNT(bouts.id) < 12
      ORDER BY events.date ASC
      LIMIT 1
    SQL
  end

end
