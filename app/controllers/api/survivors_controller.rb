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

  def trade
    Survivor.transaction do
      begin
        survivor1 = Survivor.find(params[:id])
        survivor2 = Survivor.find(params[:survivor][:id])

        survivor1_resource_type_ids = extract_ids(params[:resources], 'resource_type_id')
        survivor2_resource_type_ids = extract_ids(params[:survivor][:resources], 'resource_type_id')

        survivor1_resource_ids = extract_ids(params[:resources], 'id')
        survivor2_resource_ids = extract_ids(params[:survivor][:resources], 'id')

        survivor1_resources = survivor1.inventory.resources.where('resource_type_id IN (?)', survivor1_resource_type_ids.uniq)
        survivor2_resources = survivor2.inventory.resources.where('resource_type_id IN (?)', survivor2_resource_type_ids.uniq)

        survivor1_resources = survivor1_resources.where('id IN (?)', survivor1_resource_ids.uniq)
        survivor2_resources = survivor2_resources.where('id IN (?)', survivor2_resource_ids.uniq)

        if (points_sum(survivor1_resources) == 0) || (points_sum(survivor1_resources) != points_sum(survivor2_resources))
            raise ArgumentError
        end

        survivor1.inventory.resources.destroy(survivor1_resources)
        survivor2.inventory.resources.destroy(survivor2_resources)

        survivor2_resource_type_ids.each do |resource_type_id|
          survivor1.inventory.resources.create(resource_type_id: resource_type_id)
        end

        survivor1_resource_type_ids.each do |resource_type_id|
          survivor2.inventory.resources.create(resource_type_id: resource_type_id)
        end

        head 200

      rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors }, status: 404
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "record not found" }, status: 404
      rescue ArgumentError
        render json: { errors: "Invalid trade" }, status: 422
      end
    end
  end

  private
  def survivor_params
    params.require(:survivor).permit(:name, :age, :gender, last_location_attributes: [:latitude, :longitude])
  end

  def extract_ids(array, key)
    aux = []
    array.each do |resource|
      aux << resource[key].to_i
    end
    aux
  end

  def points_sum(resources)
    aux = 0
    resources.each do |resource|
       aux = aux + resource.resource_type.points
    end
    aux
  end
end
