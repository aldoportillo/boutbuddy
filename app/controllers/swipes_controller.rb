# SwipesController is a controller that handles actions related to Swipe resources.
class SwipesController < ApplicationController
  # POST /swipes
  # This action creates a new swipe and checks for a match
  def create
    @swipe = Swipe.new(swipe_params)

    if @swipe.save
      # If the swipe is saved successfully, check for a match
      if check_for_match(@swipe)
        # If a match is found, redirect to the event page and return
        redirect_to event_path(@bout.event_id) and return
      end
    else
      # If the swipe is not saved successfully, show an error message and render the new swipe page
      flash.now[:alert] = 'Failed to save swipe.'
      render :new and return
    end

    # If no match is found or the swipe is not saved successfully, redirect to the fighters carousel page
    redirect_to fighters_carousel_path
  end

  private

  # swipe_params is a private method that specifies the allowed parameters for a swipe
  def swipe_params
    params.require(:swipe).permit(:swiper_id, :swiped_id, :like)
  end

  # check_for_match is a private method that checks if a match exists for a swipe
  def check_for_match(swipe)
    if swipe.like
      # If the swipe is a 'like', check if a matching 'like' swipe exists
      if Swipe.exists?(swiper_id: swipe.swiped_id, swiped_id: swipe.swiper_id, like: true)
        # If a match is found, create a bout
        create_bout(swipe)
      end
    end
  end

  # create_participation is a private method that creates a participation for a user in a bout
  def create_participation(bout, user_id, corner)
    Participation.create(bout: bout, user_id: user_id, corner: corner)
  end

  # find_suitable_event is a private method that finds a suitable event for a bout
  def find_suitable_event(swiper_id, swiped_id)
    # Get the ids of events with the swiper and swiped user
    events_with_swiper = Event.joins(bouts: :participations).where(participations: { user_id: swiper_id }).ids
    events_with_swiped = Event.joins(bouts: :participations).where(participations: { user_id: swiped_id }).ids
    # Combine the ids to get the ids of events to exclude
    excluded_event_ids = events_with_swiper | events_with_swiped

    # Find an event that is not in the excluded events and has less than 6 bouts, ordered by time
    Event.where.not(id: excluded_event_ids)
        .left_joins(:bouts)
        .group('events.id')
        .having('COUNT(bouts.id) < 6')
        .order('events.time ASC')
        .first
  end

  # create_bout is a private method that creates a bout for a match
  def create_bout(swipe)
    # Find a suitable event for the bout
    suitable_event = find_suitable_event(swipe.swiper_id, swipe.swiped_id)
    return unless suitable_event
    # Create a new bout with the suitable event and the swiper's weight class
    @bout = Bout.new(event: suitable_event, 
                     weight_class_id: User.find(swipe.swiper_id).weight_class_id)
    # If the bout is saved successfully, create participations for the swiper and swiped user
    if @bout.save
      create_participation(@bout, swipe.swiper_id, 'red')
      create_participation(@bout, swipe.swiped_id, 'blue')
    end
  end
end
