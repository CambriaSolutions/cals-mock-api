module Response

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def not_found_response
    render json: {error: I18n.t('facilities_controller.facility_not_found')}, status: :not_found
  end
end
