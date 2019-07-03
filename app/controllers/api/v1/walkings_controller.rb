class Api::V1::WalkingsController < ApplicationController
  wrap_parameters :walking, include:  Walking.attribute_names.push("dog_ids")
  before_action :set_walking, only: [:show, :update, :destroy]

  # GET /walkings
  def index
    @walkings = Walking.all

    render json: @walkings
  end

  # GET /walkings/1
  def show
    render json: @walking.as_json(methods: [:dogs])
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
      begin
        @walking = Walking.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render :nothing, status: :not_found
      end
    end

    def walking_params
      params.require(:walking).permit(:status, :lat, :lon, :caregiver_id, :dog_ids => [])
    end
end
