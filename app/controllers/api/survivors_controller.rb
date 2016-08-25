class Api::SurvivorsController < ApplicationController
  def show
    survivor = Survivor.find(params[:id])
    render json: survivor
  end

  def create
    if survivor_params[:last_location_attributes].present?
      survivor = Survivor.new(survivor_params)
      survivor.create_inventory(survivor_id: survivor.id)
      if survivor.save
        render json: survivor, status: 201, location: [:api, survivor]
      else
        render json: { errors: survivor.errors }, status: 422
      end
    else
      head 422
    end
  end

  def update_location
    Survivor.transaction do
      begin
        survivor = Survivor.find(params[:id])
        if survivor
          if survivor.last_location.update(survivor_params[:last_location_attributes])
            render json: survivor.last_location, status: 200
          else
            render json: { errors: survivor.last_location.errors }, status: 422
          end
        else
          render json:{ errors: survivor.last_location.errors, status: 404 }
        end
      rescue
        render json: { errors: "Couldn't find Survivor with 'id'=#{params[:id]}" }, status: 404
      end
    end
  end

  private
  def survivor_params
    params.require(:survivor).permit(:name, :age, :gender, last_location_attributes: [:latitude, :longitude])
  end
end
