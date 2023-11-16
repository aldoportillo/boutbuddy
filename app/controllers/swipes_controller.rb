class SwipesController < ApplicationController
  def create
    @swipe = Swipe.new(swipe_params)

    respond_to do |format|
      if @swipe.save
        # Perform any additional actions upon successful swipe creation, e.g., check for match
        check_for_match(@swipe)
        # Redirect to a specified path for HTML responses
        # Replace 'some_path' with your actual redirect path, like 'fighters_carousel_path'
        format.html { redirect_to fighters_carousel_path, notice: 'Swipe was successfully created.' }

        # Return the created swipe object in JSON format for JSON responses
        format.json { render json: @swipe, status: :created, location: @swipe }
      else
        # In case of save failure, render the new form or return errors
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
    
    debugger
    bout.event = find_suitable_event

    debugger

    bout.weight_class_id = 761 ##bandaid: setting weight class statically
    

    debugger


    bout.save
  
    # if bout.save
    #   format.html { redirect_to some_path, notice: 'Swipe was successfully created.' }
    #     format.json { render json: @swipe, status: :created, location: @swipe }
    # else
    #   format.html { render :new }
    #     format.json { render json: @swipe.errors, status: :unprocessable_entity }
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
