class SwipesController < ApplicationController
  def create
    @swipe = Swipe.new(swipe_params)

    # respond_to do |format|
    #   if @swipe.save
    #     check_for_match(@swipe)
    #     format.html { redirect_to fighters_carousel_path, notice: 'Swipe was successfully created.' }
    #     format.json { render json: @swipe, status: :created, location: @swipe }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @swipe.errors, status: :unprocessable_entity }
    #   end
    # end

      if @swipe.save
        if check_for_match(@swipe)
          if create_bout(@swipe)
            redirect_to event_path(@bout.event_id) and return ##Would be cool to get to a "You have a match page" to display info on the other guy and then visit event from there definetly possible too since bout has event_id and fighter_id for now lets route directly to event
          else
            flash.now[:alert] = 'Failed to create a bout.'
            render :new and return
          end
        else
        end
      else
        flash.now[:alert] = 'Failed to save swipe.'
        render :new and return
      end
      redirect_to fighters_carousel_path
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
    
    @bout = Bout.new(red_corner_id: swipe.swiper_id, blue_corner_id: swipe.swiped_id)
    
    @bout.event = find_suitable_event

    @bout.weight_class_id = current_user.weight_class.id

    @bout.save 
    
  end

  def find_suitable_event
    Event.left_joins(:bouts)
         .group('events.id')
         .having('COUNT(bouts.id) < 12')
         .order('events.time ASC')
         .first
  end

end
