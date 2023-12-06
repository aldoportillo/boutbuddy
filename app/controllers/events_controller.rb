class EventsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_event, only: %i[ show edit update destroy ]

  # GET /events or /events.json
  def index
    
    if current_user&.role == "fighter"
      @q = current_user.events.where("time > ?", Time.now).order(time: :asc).ransack(params[:q])
      @events = @q.result
    elsif current_user&.role == "promoter"
      @q = current_user.own_events.where("time > ?", Time.now).order(time: :asc).ransack(params[:q])
      @events = @q.result
    else
      @q = Event.where("time > ?", Time.now).order(time: :asc).ransack(params[:q])
      @events = @q.result
      
    end

  end

  # GET /events/1 or /events/1.json
  def show
    @bouts = @event.bouts
  end

  # GET /events/new
  def new
    @event = Event.new
    authorize @event
  end

  # GET /events/1/edit
  def edit
    authorize @event
  end

  # POST /events or /events.json
  def create
    @event = Event.new(event_params)
    authorize @event

    if params[:event][:photo].present?
      uploaded_image = Cloudinary::Uploader.upload(params[:event][:photo], folder: "boutbuddy/events")
      @event.photo = uploaded_image['secure_url']
    end

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
  def update

    @event = Event.find(params[:id])
    authorize @event

    if params[:event][:photo].present?
      uploaded_image = Cloudinary::Uploader.upload(params[:event][:photo], folder: "boutbuddy/events")

      debugger
      @event.photo = uploaded_image['secure_url']
      debugger
    end
    
    respond_to do |format|
      if @event.update(event_params)
        debugger
        format.html { redirect_to event_url(@event), notice: "Event was successfully updated." }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1 or /events/1.json
  def destroy
    @event.destroy
    authorize @event

    respond_to do |format|
      format.html { redirect_to events_url, notice: "Event was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def bouts
    @event = Event.find(params[:id])
    @bouts = @event.bouts
  
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end
  
  def messages
    @event = Event.find(params[:id])
    @messages = @event.messages
  
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event
      @event = Event.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def event_params
      params.require(:event).permit(:title, :time, :price, :bio, :venue_id, :promoter_id)
    end
end
