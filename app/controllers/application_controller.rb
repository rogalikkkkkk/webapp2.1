class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound do
    render json: { error: "No such record in Database; check params", status: :not_found }
  end
  rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
  def handle_record_invalid(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end

  rescue_from ActionController::ParameterMissing, with: :handle_missing_parameter
  def handle_missing_parameter(exception)
    render json: { error: exception.message }, status: :bad_request
  end

  rescue_from ActionController::RoutingError do |exception|
    logger.error "Routing error occurred: #{exception}"
    # render plain: '404 Not found', status: 404
    render json: { error: "No route matches; check routes",
                   status: :no_route,
    }
  end
  def catch_404
    raise ActionController::RoutingError.new(params[:path])
  end


  rescue_from ActionController::UnpermittedParameters, with: :handle_unpermitted_parameters
  def handle_unpermitted_parameters(exception)
    render json: { error: "Unpermitted parameters: #{exception.params.join(', ')}" }, status: :bad_request
  end

end
