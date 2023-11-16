class SwipesController < ApplicationController
  def create
    @swipe = Swipe.new(swipe_params)

    respond_to do |format|
      if @swipe.save
        check_for_match(@swipe)
        format.html { redirect_to fighters_carousel_path, notice: 'Swipe was successfully created.' }
        format.json { render json: @swipe, status: :created, location: @swipe }
      else
        format.html { render :new }
        format.json { render json: @swipe.errors, status: :unprocessable_entity }
      end
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

    bout.weight_class_id = current_user.weight_class.id

    bout.save #Need a way to notify user but l8r
    # respond_to do |format|
    #   if bout.save
    #     format.html { redirect_to fighters_carousel_path, notice: 'You have a match! Click on "My Events" for details!.' }
    #     format.json { render json: @swipe, status: :created, location: @swipe }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @swipe.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  def find_suitable_event
    Event.left_joins(:bouts)
         .group('events.id')
         .having('COUNT(bouts.id) < 12')
         .order('events.time ASC')
         .first
  end

end
