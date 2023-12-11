# MessagesController is a controller that handles actions related to Message resources.
class MessagesController < ApplicationController
  # Before any action, set the event and message (for specific actions only)
  before_action :set_event
  before_action :set_message, only: %i[ show edit update destroy ]

  # GET /messages or /messages.json
  # This action lists all messages and initializes a new message
  def index
    @messages = Message.all
    @message = Message.new

    # Respond to the request in HTML format
    respond_to do |format|
      format.html
    end
  end

  # GET /messages/1 or /messages/1.json
  # This action shows a specific message
  def show
  end

  # GET /messages/new
  # This action initializes a new message
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  # This action is for editing a specific message
  def edit
  end

  # POST /messages or /messages.json
  # This action creates a new message
  def create
    @message = Message.new(message_params)

    # Save the message and respond to the request in HTML or JSON format
    respond_to do |format|
      if @message.save
        format.html { redirect_to event_messages_path(message_params["event_id"]), notice: "Message was successfully created." }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { redirect_to event_messages_path(message_params["event_id"]), notice: "Error Sending Message." }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1 or /messages/1.json
  # This action updates a specific message
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to message_url(@message), notice: "Message was successfully updated." }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1 or /messages/1.json
  # This action destroys a specific message
  def destroy
    @message.destroy

    # Respond to the request in HTML or JSON format
    respond_to do |format|
      format.html { redirect_to messages_url, notice: "Message was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # set_message is a private method that sets the @message instance variable
    def set_message
      @message = Message.find(params[:id])
    end

    # set_event is a private method that sets the @event instance variable
    def set_event
      @event = Event.find(params[:event_id])
    end

    # message_params is a private method that specifies the allowed parameters for a message
    def message_params
      params.require(:message).permit(:event_id, :user_id, :content)
    end
end
