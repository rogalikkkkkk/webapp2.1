class Api::V1::GeeksController < ApplicationController
  before_action :set_geek, only: [:show, :update, :destroy]

  def index
    if params[:id]
      @geeks = Geek.where(id: params[:id])
    else
      @geeks = Geek.all
    end

    # Фильтрация по имени
    if params[:name]
      @geeks = @geeks.where("name LIKE ?", "%#{params[:name]}%")
    end

    # Фильтрация по стеку технологий
    if params[:stack]
      @geeks = @geeks.where("stack LIKE ?", "%#{params[:stack]}%")
    end

    render json: @geeks
  end
  def show
    render json: @geek
  end

  def create
    @geek = Geek.new(geek_params)

    if @geek.save
      render json: @geek, status: :created
    else
      render json: { errors: @geek.errors.full_messages, status: :no_content}
    end
  end

  def update
    if @geek.update(geek_params)
      render json: @geek
    else
      render json: { errors: @geek.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update_resume
    @selected_geek = Geek.find(params[:geek_id])

    if @selected_geek.update(resume: params[:new_resume])
      render json: @selected_geek
    else
      render json: { errors: @selected_geek.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @geek.destroy
    render json: { deleted_geek: @geek, status: :success }
  end

  def geek_all_applies
    @readed_by_geek = Geek.find(params[:geek_id]).applies

    render json: @readed_by_geek
  end

  def readed_by_geek
    @readed_by_geek = Geek.find(params[:geek_id]).applies.where(read: true)

    render json: @readed_by_geek
  end

  def accepted_applies
    @accepted_applies = Geek.find(params[:geek_id]).applies.where(invited: true)

    render json: @accepted_applies
  end

  private

  def set_geek
    @geek = Geek.find(params[:id])
  end

  # Параметры для соискателя
  def geek_params
    params.permit(:name, :stack, :resume)
  end

  def geek_params_resume
    params.permit(:geek_id, :resume)
  end
end
