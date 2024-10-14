class Api::V1::JobsController < ApplicationController
  before_action :set_job, only: [ :show, :update, :destroy ]

  def index
    if params[:company_id]
      @jobs = Company.find(params[:company_id]).jobs
    else
      @jobs = Job.all
    end

    # Фильтрация по названию работы
    if params[:name]
      @jobs = @jobs.where(name: params[:name])
    end

    # Фильтрация по расположению
    if params[:place]
      @jobs = @jobs.where(place: params[:place])
    end

    render json: { jobs: @jobs }, except: [ :id, :created_at, :updated_at ]
  end

  def show
    render json: @job
  end

  def create
    @job = Job.new(job_params)
    if @job.save
      render json: { job: @job }, status: :created, except: [ :id, :created_at, :updated_at ]
    else
      render json: { user: @job.errors, status: :no_content }
    end
  end

  def update
    if @job.update(job_params)
      render json: @job
    else
      render json: @job.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @job.destroy
    render json: { deleted_job: @job, status: :success }
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.permit(:place, :company_id, :name)
  end
end
