class Api::V1::WalkingsController < ApplicationController
  before_action :set_walking, only: [:show, :update, :destroy]

  # GET /walkings
  def index
    @walkings = Walking.all

    render json: @walkings
  end

  # GET /walkings/1
  def show
    render json: @walking
  end

  # POST /walkings
  def create
    @walking = Walking.new(walking_params)

    if @walking.save
      render json: @walking, status: :created, location: api_v1_walking_url(@walking)
    else
      render json: @walking.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /walkings/1
  def update
    if @walking.update(walking_params)
      render json: @walking
    else
      render json: @walking.errors, status: :unprocessable_entity
    end
  end

  # DELETE /walkings/1
  def destroy
    @walking.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_walking
      @walking = Walking.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def walking_params
      params.require(:walking).permit(:status, :lat, :lon, :caregiver_id)
    end
end
