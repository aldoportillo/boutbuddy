# WeightClassesController is a controller that handles actions related to WeightClass resources.
class WeightClassesController < ApplicationController
  # Before any action, set the weight class for actions that need it
  before_action :set_weight_class, only: %i[ show edit update destroy ]

  # GET /weight_classes or /weight_classes.json
  # This action lists all weight classes
  def index
    @weight_classes = WeightClass.all
  end

  # GET /weight_classes/1 or /weight_classes/1.json
  # This action shows a specific weight class
  def show
  end

  # GET /weight_classes/new
  # This action initializes a new weight class
  def new
    @weight_class = WeightClass.new
  end

  # GET /weight_classes/1/edit
  # This action edits a specific weight class
  def edit
  end

  # POST /weight_classes or /weight_classes.json
  # This action creates a new weight class
  def create
    @weight_class = WeightClass.new(weight_class_params)

    respond_to do |format|
      if @weight_class.save
        format.html { redirect_to weight_class_url(@weight_class), notice: "Weight class was successfully created." }
        format.json { render :show, status: :created, location: @weight_class }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @weight_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weight_classes/1 or /weight_classes/1.json
  # This action updates a specific weight class
  def update
    respond_to do |format|
      if @weight_class.update(weight_class_params)
        format.html { redirect_to weight_class_url(@weight_class), notice: "Weight class was successfully updated." }
        format.json { render :show, status: :ok, location: @weight_class }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @weight_class.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weight_classes/1 or /weight_classes/1.json
  # This action destroys a specific weight class
  def destroy
    @weight_class.destroy

    respond_to do |format|
      format.html { redirect_to weight_classes_url, notice: "Weight class was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # set_weight_class is a private method that finds a weight class by its id
    def set_weight_class
      @weight_class = WeightClass.find(params[:id])
    end

    # weight_class_params is a private method that sanitizes the incoming parameters to only allow the name, min, and max
    def weight_class_params
      params.require(:weight_class).permit(:name, :min, :max)
    end
end
