class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response

  layout "default"

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [:name]
    )

    devise_parameter_sanitizer.permit(
      :account_update, keys: [:name, :birthdate, :gender]
    )
  end

  private

  def not_found_response
    redirect_back fallback_location: root_path,
                  alert: "Not found or not allowed to continue",
                  status: :not_found
  end
end
