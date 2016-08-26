class Api::ReportsController < ApplicationController
  def infected_survivors
    survivors = Survivor.all

    if survivors.length > 0
      infected_survivors = survivors.where("infected = 1")
      percentage = (infected_survivors.length.to_f / survivors.length) * 100
      percentage = percentage.to_s + '%'
      render json: {:infected_survivors_percentage => percentage}, status: 200
    else
      render json: {:error => "Sorry, there are no survivors beyond you."}, status: 404
    end
  end

  def non_infected_survivors
    survivors = Survivor.all

    if survivors.length > 0
      non_infected_survivors = survivors.where("infected = 0")
      percentage = (non_infected_survivors.length.to_f / survivors.length) * 100
      percentage = percentage.to_s + '%'
      render json: {:non_infected_survivors_percentage => percentage}, status: 200
    else
      render json: {:error => "Sorry, there are no survivors beyond you."}, status: 404
    end
  end

  def resources_avg
    survivors_count = Survivor.all.count
    if survivors_count > 0
      resources_count = Resource.all.group(:resource_type_id).count
      resource_types = ResourceType.all
      resources_avg = {}
      resource_types.each do |resource_type, count|
        if resources_count[resource_type.id]
          resources_avg[resource_type.description] = resources_count[resource_type.id] / survivors_count
        else
          resources_avg[resource_type.description] = 0
        end
      end
      render json: resources_avg, status: 200
    else
      render json: {:error => "Sorry, there are no survivors beyond you."}, status: 404
    end
  end
end
