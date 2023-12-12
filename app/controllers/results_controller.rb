# ResultsController is a controller that handles actions related to Result resources.
class ResultsController < ApplicationController
  # Before any action, set the event and bout
  before_action :set_event_and_bout

  # GET /results/new
  # This action initializes a new result
  def new
    @result = Result.new
  end

  # POST /results
  # This action creates a new result for a bout
  def create
    # Build a new result associated with the bout
    @result = @bout.build_result(result_params)

    # Try to save the result
    if @result.save
      # If successful, redirect to the event page with a success notice
      redirect_to event_path(@event), notice: 'Result was successfully created.'
    else
      # If not successful, redirect to the event page with an error notice
      redirect_to event_path(@event), notice: 'There was an issue saving this result.'
    end
  end

  private

  # set_event_and_bout is a private method that sets the @event and @bout instance variables
  def set_event_and_bout
    @event = Event.find(params[:event_id])
    @bout = @event.bouts.find(params[:bout_id])
  end

  # result_params is a private method that specifies the allowed parameters for a result
  def result_params
    params.require(:result).permit(:winner_id, :win_by_id)
  end
end
