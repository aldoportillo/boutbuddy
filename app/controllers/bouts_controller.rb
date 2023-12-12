# BoutsController is a controller that handles actions related to Bout resources.
class BoutsController < ApplicationController
  # Before any action, set the event and bout (for specific actions only)
  before_action :set_event
  before_action :set_bout, only: %i[ show edit update destroy ]

  # GET /bouts or /bouts.json
  # This action lists all bouts for a specific event
  def index
    @bouts = @event.bouts

    # Respond to the request in HTML or Turbo Stream format
    respond_to do |format|
      format.html
      format.turbo_stream { render partial: 'bouts/content', locals: { bouts: @bouts } }
    end
  end

  # GET /bouts/1 or /bouts/1.json
  # This action shows a specific bout
  def show
  end

  # GET /bouts/new
  # This action initializes a new bout
  def new
    @bout = Bout.new
  end

  # GET /bouts/1/edit
  # This action is for editing a specific bout
  def edit
  end

  # POST /bouts or /bouts.json
  # This action creates a new bout
  def create
    @bout = Bout.new(bout_params)

    # Respond to the request in HTML or JSON format
    respond_to do |format|
      if @bout.save
        format.html { redirect_to event_url(@bout.event), notice: "Bout was successfully created." }
        format.json { render :show, status: :created, location: @bout }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @bout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bouts/1 or /bouts/1.json
  # This action updates a specific bout
  def update
    respond_to do |format|
      if @bout.update(bout_params)
        format.html { redirect_to bout_url(@bout), notice: "Bout was successfully updated." }
        format.json { render :show, status: :ok, location: @bout }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @bout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bouts/1 or /bouts/1.json
  # This action destroys a specific bout
  def destroy
    @bout.destroy

    # Respond to the request in HTML or JSON format
    respond_to do |format|
      format.html { redirect_to bouts_url, notice: "Bout was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # bout_params is a private method that specifies the allowed parameters for a bout
    def bout_params
      params.require(:bout).permit(:event_id, :weight_class_id)
    end

    # set_event is a private method that sets the @event instance variable
    def set_event
      @event = Event.find(params[:event_id])
    end

    # set_bout is a private method that sets the @bout instance variable
    def set_bout
      @bout = @event.bouts.find(params)
    end
end
