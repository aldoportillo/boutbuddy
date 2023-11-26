class ResultsController < ApplicationController
  before_action :set_event_and_bout

  def new
    @result = Result.new
  end

  def create
    @result = @bout.build_result(result_params)

    if @result.save
      redirect_to event_path(@event), notice: 'Result was successfully created.'
    else
      render :new
    end
  end

  private

  def set_event_and_bout
    @event = Event.find(params[:event_id])
    @bout = @event.bouts.find(params[:bout_id])
  end

  def result_params
    params.require(:result).permit(:winner_id, :win_by)
  end
end
