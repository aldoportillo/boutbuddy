class VenuesController < ApplicationController
  require 'httparty'
  before_action :set_venue, only: %i[ show edit update destroy ]
  

  # GET /venues or /venues.json
  # def index
  #   ##USE PUNDIT FOR THIS LATER
  #   if current_user&.role == "promoter"
  #     @venues = current_user.own_venues
  #   else
  #     @venues = Venue.all
  #   end
  # end
  def index
    @venues = policy_scope(Venue)
  end

  # GET /venues/1 or /venues/1.json
  def show
    authorize @venue
  end

  # GET /venues/new
  def new
    @venue = Venue.new
    authorize @venue
  end

  # GET /venues/1/edit
  def edit
    authorize @venue
  end

  # POST /venues or /venues.json
  def create
    @venue = Venue.new(venue_params)
    authorize @venue
    

    lat, lng = get_coordinates_from_address(@venue.address)

    if lat && lng
      @venue.lat = lat
      @venue.lng = lng

      respond_to do |format|
        if @venue.save
          format.html { redirect_to venue_url(@venue), notice: "Venue was successfully created." }
          format.json { render :show, status: :created, location: @venue }
        else
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @venue.errors, status: :unprocessable_entity }
        end
      end
    else
      @venue.errors.add(:address, "could not be geocoded")
      render :new
    end
  end

  # PATCH/PUT /venues/1 or /venues/1.json
  def update
    authorize @venue
    
    respond_to do |format|
      if @venue.update(venue_params)
        format.html { redirect_to venue_url(@venue), notice: "Venue was successfully updated." }
        format.json { render :show, status: :ok, location: @venue }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1 or /venues/1.json
  def destroy
    authorize @venue
    @venue.destroy

    respond_to do |format|
      format.html { redirect_to venues_url, notice: "Venue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_venue
      @venue = Venue.find(params[:id])
    end

    def venue_params
      params.require(:venue).permit(:name, :address, :promoter_id)
    end
  
    def get_coordinates_from_address(address)
      api_key = ENV['GOOGLE_MAPS_API_KEY']
      base_url = "https://maps.googleapis.com/maps/api/geocode/json"
      encoded_address = URI.encode_www_form_component(address)
      request_url = "#{base_url}?address=#{encoded_address}&key=#{api_key}"

      response = HTTParty.get(request_url)
  
      if response.code == 200
        result = JSON.parse(response.body)
        if result["status"] == "OK"
          location = result["results"][0]["geometry"]["location"]
          return location["lat"], location["lng"]
        else
          Rails.logger.error "Geocoding failed with status: #{result["status"]}"
          return nil
        end
      else
        Rails.logger.error "HTTP Request failed with code: #{response.code}"
        return nil
      end
    end
end
