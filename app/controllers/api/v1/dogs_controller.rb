class Api::V1::DogsController < ApplicationController
  before_action :set_client
  before_action :set_dog, only: [:show, :update, :destroy]

  # GET /dogs
  def index
    @dogs = @client.dogs.all

    render json: @dogs
  end

  # GET /dogs/1
  def show
    render json: @dog
  end

  # POST /dogs
  def create
    @dog = @client.dogs.build(dog_params)

    if @dog.save
      render json: @dog, status: :created, location: api_v1_client_dog_url(@client, @dog)
    else
      render json: @dog.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dogs/1
  def update
    if @dog.update(dog_params)
      render json: @dog
    else
      render json: @dog.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dogs/1
  def destroy
    @dog.destroy
  end

  private
    def set_dog
      begin
        @dog = @client.dogs.find(params[:id])
      rescue ActiveRecord::RecordNotFound
        return render :nothing, status: :not_found
      end
    end

    def set_client
      begin
        @client = Client.find(params[:client_id])
      rescue ActiveRecord::RecordNotFound
        return render :nothing, status: :not_found
      end
    end

    def dog_params
      params.require(:dog).permit(:name, :client_id)
    end
end
