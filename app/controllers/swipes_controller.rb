class SwipesController < ApplicationController
  def create
    @swipe = Swipe.new(swipe_params)
  
    if @swipe.save
      if check_for_match(@swipe)
        # Handling match scenario
        # Redirecting to a match page or event page can be handled here
        # For now, as per your comment, redirecting to the event page
        redirect_to event_path(@bout.event_id) and return
      else
        # Fetch the next fighter

        session[:index] += 1
        next_fighter_id = session[:fighters][session[:index]]
        @next_fighter = User.find(next_fighter_id) if next_fighter_id

        respond_to do |format|
          format.turbo_stream do
            render turbo_stream: turbo_stream.replace("fighter_card", partial: "users/fighter_profile_card", locals: { fighter: @next_fighter })
          end
          format.html { redirect_to fighters_carousel_path }
        end
        return
      end
    else
      flash.now[:alert] = 'Failed to save swipe.'
      render :new and return
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

  def create_participation(bout, user_id, corner)
    Participation.create(bout: bout, user_id: user_id, corner: corner)
  end

  def find_suitable_event(swiper_id, swiped_id)
    # Get the ids of events in which either user is already participating
    events_with_swiper = Event.joins(bouts: :participations).where(participations: { user_id: swiper_id }).ids
    events_with_swiped = Event.joins(bouts: :participations).where(participations: { user_id: swiped_id }).ids
    excluded_event_ids = events_with_swiper | events_with_swiped

    # Find a suitable event that neither user is part of
    Event.where.not(id: excluded_event_ids)
        .left_joins(:bouts)
        .group('events.id')
        .having('COUNT(bouts.id) < 12')
        .order('events.time ASC')
        .first
  end

  def create_bout(swipe)
    suitable_event = find_suitable_event(swipe.swiper_id, swipe.swiped_id)
    return unless suitable_event
    @bout = Bout.new(event: suitable_event, 
                     weight_class_id: User.find(swipe.swiper_id).weight_class_id)
    if @bout.save
      create_participation(@bout, swipe.swiper_id, 'red')
      create_participation(@bout, swipe.swiped_id, 'blue')
    end
  end

end
