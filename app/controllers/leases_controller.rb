class LeasesController < ApplicationController
    # rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_entry

    def create
        lease = Lease.create!(lease_params)
        render json: lease, status: :ok
    end

    def destroy
        lease = find_lease
        lease.destroy
        head :no_content
    end

    private

    def not_found
        render json: {error: "Record not found"}, status: :not_found
    end

    def invalid_entry
        render json: {error: "Invalid entry"}, status: :unprocessable_entity
    end

    def lease_params
        params.permit(:apartment_id, :tenant_id, :rent)
    end

    def find_lease
        Lease.find_by!(id: params[:id])
    end
end
