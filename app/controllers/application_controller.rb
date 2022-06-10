class ApplicationController < ActionController::API
    rescue_from ActionController::RoutingError, with: :not_found

    private

    def not_found
        render json: {error: "Not found"}, status: :not_found
    end
end
