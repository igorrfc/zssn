class Api::InfectedReportsController < ApplicationController
  def create
    Survivor.transaction do
      begin
        survivor = Survivor.find(infected_report_params[:survivor_id])
        infected_report = InfectedReport.new(infected_report_params)
        if infected_report.save
          survivor_reports = InfectedReport.where("survivor_id = ?", infected_report_params[:survivor_id])
          if survivor_reports.length == 3
            survivor.update_attribute(:infected, 1)
            survivor.inventory.update_attribute(:available, 0)
          end
          render json: infected_report, status: 201, location: [:api, infected_report]
        end
      rescue ActiveRecord::RecordNotFound
        render json: { errors: "Survivor doesn't exists" }, status: 404
      end
    end
  end

  private
  def infected_report_params
    params.require(:survivor).permit(:survivor_id)
  end
end
