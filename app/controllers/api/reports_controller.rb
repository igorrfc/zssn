class Api::ReportsController < ApplicationController
  def infected_survivors
    survivors = Survivor.all

    if survivors.length > 0
      infected_survivors = Survivor.where("infected = 1")
      percentage = (infected_survivors.length.to_f / survivors.length) * 100
      percentage = percentage.to_s + '%'
      render json: {:infected_survivors_percentage => percentage}, status: 200
    else
      render json: {:error => "Sorry, there are no survivors"}, status: 404
    end
  end

  def non_infected_survivors
    survivors = Survivor.all

    if survivors.length > 0
      non_infected_survivors = Survivor.where("infected = 0")
      percentage = (non_infected_survivors.length.to_f / survivors.length) * 100
      percentage = percentage.to_s + '%'
      render json: {:non_infected_survivors_percentage => percentage}, status: 200
    else
      render json: {:error => "Sorry, there are no survivors"}, status: 404
    end
  end
end
