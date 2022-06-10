class ApartmentsController < ApplicationController
rescue_from ActiveRecord::RecordNotFound, with: :not_found
rescue_from ActiveRecord::RecordInvalid, with: :invalid_entry
    def index
        apartments = Apartment.all
        render json: apartments, status: :ok
    end

    def show
        apartment = find_apartment
        render json: apartment, status: :ok
    end

    def create
        apartment = Apartment.create(apartment_params)
        render json: apartment, status: :ok
    end

    def update
        apartment = find_apartment
        apartment.update(apartment_params)
        render json: apartment, status: :ok
    end

    def destroy
        apartment = find_apartment
        apartment.destroy
        head :no_content
    end

    private

    def not_found
        render json: {error: "Record not found"}, status: :not_found
    end

    def invalid_entry
        render json: {error: "Invalid entry"}, status: :unprocessable_entity
    end

    def apartment_params
        params.permit(:number)
    end

    def find_apartment
        Apartment.find_by!(id: params[:id])
    end
end
