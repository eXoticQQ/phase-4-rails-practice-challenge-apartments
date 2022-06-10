class TenantsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid, with: :invalid_entry
    def index
        tenants = Tenant.all
        render json: tenants, status: :ok
    end

    def show
        tenant = find_tenant
        render json: tenant, status: :ok
    end

    def create
        tenant = Tenant.create!(tenant_params)
        render json: tenant, status: :ok
    end

    def update
        tenant = find_tenant
        tenant.update!(tenant_params)
        render json: tenant, status: :ok
    end

    def destroy
        tenant = find_tenant
        tenant.destroy
        head :no_content
    end

    private

    def not_found
        render json: {error: "Record not found"}, status: :not_found
    end

    def invalid_entry
        render json: {error: "Invalid entry"}, status: :unprocessable_entity
    end

    def tenant_params
        params.permit(:name, :age)
    end

    def find_tenant
        Tenant.find_by!(id: params[:id])
    end
end
