class RequestsController < ApplicationController

  def request
    Request.make_api_call(params[:origin_city],
                          params[:origin_country],
                          params[:origin_state],
                          params[:origin_zip],
                          params[:destination_country],
                          params[:destination_city],
                          params[:destination_state],
                          params[:destination_zip],
                          params[:package_weight],
                          params[:package_height],
                          params[:package_depth],
                          params[:package_length])
  end
end
