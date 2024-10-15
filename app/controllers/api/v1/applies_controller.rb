class Api::V1::AppliesController < ApplicationController
  before_action :set_apply, only: [:show, :update, :destroy]

  def index
    @applies = Apply.all

    # Фильтрация по прочтению
    if params[:read]
      @applies = @applies.where(read: params[:read])
    end

    # Фильтрация по приглашению
    if params[:invited]
      @applies = @applies.where(invited: params[:invited])
    end

    render json: @applies
  end

  def show
    render json: @apply
  end

  def create
    if Apply.where(geek_id: params[:geek_id], job_id: params[:job_id]).exists?
      render json: { error: "This record already exists", status: :bad_request }
      return
    end

    @apply = Apply.new(apply_params)

    if @apply.save
      render json: @apply, status: :created
    else
      render json: @apply.errors, status: :unprocessable_entity
    end
  end

  # PUT /applies/:id
  def update
    if @apply.update(apply_params)
      render json: @apply
    else
      render json: @apply.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @apply.destroy
    render json: @apply
  end

  private
  def set_apply
    @apply = Apply.find(params[:id])
  end

  def apply_params
    params.permit(:job_id, :geek_id, :read, :invited)
  end
end
