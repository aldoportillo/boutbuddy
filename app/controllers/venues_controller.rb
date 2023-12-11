# VenuesController is a controller that handles actions related to Venue resources.
class VenuesController < ApplicationController
  # Include the HTTParty gem to make HTTP requests
  require 'httparty'
  # Before any action, authenticate the user and set the venue for actions that need it
  before_action :authenticate_user!
  before_action :set_venue, only: %i[ show edit update destroy ]

  # GET /venues or /venues.json
  # This action lists all venues that the current user is authorized to see
  def index
    @venues = policy_scope(Venue)
  end

  # GET /venues/1 or /venues/1.json
  # This action shows a specific venue if the current user is authorized to see it
  def show
    authorize @venue
  end

  # GET /venues/new
  # This action initializes a new venue if the current user is authorized to create it
  def new
    @venue = Venue.new
    authorize @venue
  end

  # GET /venues/1/edit
  # This action edits a specific venue if the current user is authorized to edit it
  def edit
    authorize @venue
  end

  # POST /venues or /venues.json
  # This action creates a new venue if the current user is authorized to create it
  def create
    @venue = Venue.new(venue_params)
    authorize @venue

    # Get the latitude and longitude from the venue's address
    lat, lng = get_coordinates_from_address(@venue.address)

    if lat && lng
      # If the latitude and longitude are found, set them on the venue
      @venue.lat = lat
      @venue.lng = lng

      # Try to save the venue
      respond_to do |format|
        if @venue.save
          # If successful, redirect to the venue page with a success notice
          format.html { redirect_to venue_url(@venue), notice: "Venue was successfully created." }
          format.json { render :show, status: :created, location: @venue }
        else
          # If not successful, render the new venue page with an error status
          format.html { render :new, status: :unprocessable_entity }
          format.json { render json: @venue.errors, status: :unprocessable_entity }
        end
      end
    else
      # If the latitude and longitude are not found, add an error to the venue and render the new venue page
      @venue.errors.add(:address, "could not be geocoded")
      render :new
    end
  end

  # PATCH/PUT /venues/1 or /venues/1.json
  # This action updates a specific venue if the current user is authorized to update it
  def update
    authorize @venue

    # Try to update the venue
    respond_to do |format|
      if @venue.update(venue_params)
        # If successful, redirect to the venue page with a success notice
        format.html { redirect_to venue_url(@venue), notice: "Venue was successfully updated." }
        format.json { render :show, status: :ok, location: @venue }
      else
        # If not successful, render the edit venue page with an error status
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @venue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /venues/1 or /venues/1.json
  # This action destroys a specific venue if the current user is authorized to destroy it
  def destroy
    authorize @venue
    @venue.destroy

    # Redirect to the venues page with a success notice
    respond_to do |format|
      format.html { redirect_to venues_url, notice: "Venue was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
  # set_venue is a private method that finds a venue by its id
  def set_venue
    @venue = Venue.find(params[:id])
  end

  def venue_params
  # venue_params is a private method that sanitizes the incoming parameters to only allow the name, address, and promoter_id
  params.require(:venue).permit(:name, :address, :promoter_id)
  end

   # get_coordinates_from_address is a private method that uses the Google Maps Geocoding API to get the latitude and longitude froman address
   def get_coordinates_from_address(address)
     # Get the Google Maps API key from the environment variables
     api_key = ENV['GOOGLE_MAPS_API_KEY']
     # Define the base URL for the Google Maps Geocoding API
     base_url = "https://maps.googleapis.com/maps/api/geocode/json"
     # URL encode the address
     encoded_address = URI.encode_www_form_component(address)
     # Construct the full request URL
     request_url = "#{base_url}?address=#{encoded_address}&key=#{api_key}"
     # Make a GET request to the Google Maps Geocoding API
    response = HTTParty.get(request_url)
    # Check the HTTP response code
    if response.code == 200
      # If the response code is 200 (OK), parse the response body as JSON
      result = JSON.parse(response.body)
      # Check the status of the geocoding request
      if result["status"] == "OK"
        # If the status is OK, get the location data from the response
        location = result["results"][0]["geometry"]["location"]
        # Return the latitude and longitude
        return location["lat"], location["lng"]
      else
        # If the status is not OK, log an error and return nil
        Rails.logger.error "Geocoding failed with status: #{result["status"]}"
        return nil
      end
    else
      # If the response code is not 200, log an error and return nil
      Rails.logger.error "HTTP Request failed with code: #{response.code}"
      return nil
    end
  end
end
