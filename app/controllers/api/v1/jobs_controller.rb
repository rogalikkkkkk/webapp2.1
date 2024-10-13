class Api::V1::JobsController < ApplicationController
  def index
    render json: Job.all
  end
end
