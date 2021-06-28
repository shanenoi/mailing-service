class ApplicationController < ActionController::API
  def authen_params
    %i[api_key, api_name]
  end
end
