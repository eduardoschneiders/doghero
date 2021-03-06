class Api::V1::CaregiversController < ApplicationController
  before_action :set_caregiver, only: [:show, :update, :destroy]

  # GET /caregivers
  def index
    @caregivers = Caregiver.all

    render json: @caregivers
  end

  # GET /caregivers/1
  def show
    render json: @caregiver
  end

  # POST /caregivers
  def create
    @caregiver = Caregiver.new(caregiver_params)

    if @caregiver.save
      render json: @caregiver, status: :created, location: api_v1_caregiver_url(@caregiver)
    else
      render json: @caregiver.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /caregivers/1
  def update
    if @caregiver.update(caregiver_params)
      render json: @caregiver
    else
      render json: @caregiver.errors, status: :unprocessable_entity
    end
  end

  # DELETE /caregivers/1
  def destroy
    @caregiver.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_caregiver
      begin
        @caregiver = Caregiver.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        render :nothing, status: :not_found
      end
    end

    # Only allow a trusted parameter "white list" through.
    def caregiver_params
      params.require(:caregiver).permit(:name)
    end
end
