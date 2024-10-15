class Api::V1::CompaniesController < ApplicationController
  before_action :set_company, only: [ :show, :update, :destroy ]

  def index
    if params[:id]
      @companies = Company.where(id: params[:id])
    else
      @companies = Company.all
    end

    # Фильтрация по названию компании
    if params[:name]
      @companies = @companies.where("name LIKE ?", "%#{params[:name]}%")
    end

    # Фильтрация по расположению
    if params[:location]
      @companies = @companies.where("location LIKE ?", "%#{params[:location]}%")
    end

    render json: @companies
  end

  def show
    render json: @company
  end

  def create
    @company = Company.new(company_params)

    if @company.save
      render json: @company, status: :created
    else
      render json: { company: @company.errors, status: :no_content }
    end
  end

  def destroy
    @company.destroy
    render json: { deleted_company: @company, status: :success }
  end

  def update
    if @company.update(company_params)
      render json: @company
    else
      render json: @company.errors, status: :unprocessable_content
    end
  end

  private
  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params.permit(:location, :name)
  end
end
