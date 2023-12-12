# EventsController is a controller that handles actions related to Event resources.
class EventsController < ApplicationController
  # Before any action, authenticate the user (except for index and show actions)
  # and set the event (for specific actions only)
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  # This action lists all events based on the role of the current user
  def index
    # If the current user is a fighter, show their future events
    # If the current user is a promoter, show their own future events
    # If the current user is neither, show all future events
    if current_user&.role == "fighter"
      @q = current_user.events.where("time > ?", Time.now).order(time: :asc).ransack(params[:q])
    elsif current_user&.role == "promoter"
      @q = current_user.own_events.where("time > ?", Time.now).order(time: :asc).ransack(params[:q])
    else
      @q = Event.where("time > ?", Time.now).order(time: :asc).ransack(params[:q])
    end
    @events = @q.result
  end

  # GET /events/1 or /events/1.json
  # This action shows a specific event
  def show
    @bouts = @event.bouts
  end

  # GET /events/new
  # This action initializes a new event
  def new
    @event = Event.new
    authorize @event
  end

  # GET /events/1/edit
  # This action is for editing a specific event
  def edit
    authorize @event
  end

  # POST /events or /events.json
  # This action creates a new event
  def create
    @event = Event.new(event_params)
    authorize @event

    # If a photo is provided, upload it to Cloudinary and set the photo URL
    if params[:event][:photo].present?
      uploaded_image = Cloudinary::Uploader.upload(params[:event][:photo], folder: "boutbuddy/events")
      @event.photo = uploaded_image['secure_url']
    end

    # Save the event and respond to the request in HTML or JSON format
    respond_to do |format|
      if @event.save
        format.html { redirect_to event_url(@event), notice: "Event was successfully created." }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1 or /events/1.json
  # This action updates a specific event
  def update
    authorize @event

    # If a new photo is provided, upload it to Cloudinary and update the photo URL
    if params[:event][:photo].present?
      uploaded_image = Cloudinary::Uploader.upload(params[:event][:photo], folder: "boutbuddy/events")
      @event.photo = uploaded_image['secure_url']
    end

    # Update the event and respond to the request in HTML or JSON format
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  # This action destroys a specific event
  def destroy
    @event.destroy
    authorize @event

    # Respond to the request in HTML or JSON format
    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  # GET /events/1/bouts
  # This action lists all bouts for a specific event
  def bouts
    @bouts = @event.bouts

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  # GET /events/1/messages
  # This action lists all messages for a specific event
  def messages
    @messages = @event.messages

    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private
    # set_event is a private method that sets the @event instance variable
    def set_event
      @event = Event.find(params[:id])
    end

    # event_params is a private method that specifies the allowed parameters for an event
    def event_params
      params.require(:event).permit(:title, :time, :price, :bio, :venue_id, :promoter_id)
    end
end
