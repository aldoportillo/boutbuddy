class BoutsController < ApplicationController
  before_action :set_event
  before_action :set_bout, only: %i[ show edit update destroy ]

  # GET /bouts or /bouts.json
  def index
    #@bouts = Bout.all
    @bouts = @event.bouts

    respond_to do |format|
      format.html
      format.turbo_stream { render partial: 'bouts/content', locals: { bouts: @bouts } }
    end
  end

  # GET /bouts/1 or /bouts/1.json
  def show
  end

  # GET /bouts/new
  def new
    @bout = Bout.new
  end

  # GET /bouts/1/edit
  def edit
  end

  # POST /bouts or /bouts.json
  def create
    @bout = Bout.new(bout_params)

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
  def destroy
    @bout.destroy

    respond_to do |format|
      format.html { redirect_to bouts_url, notice: "Bout was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_bout
    #   @bout = Bout.find(params[:id])
    # end

    # Only allow a list of trusted parameters through.
    def bout_params
      params.require(:bout).permit(:event_id, :weight_class_id)
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_bout
      @bout = @event.bouts.find(params)
    end
end
