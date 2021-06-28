class ApplicationController < ActionController::API
  def authen_params
    %i[api_key, api_name]
  end

  def account
    return render json: {message: 'Authentication Failure'},
                  status: :unauthorized \
    unless params[:invited_code] == ENV['INVITED_CODE']

    password = random_password
    application = Application.new name: params[:api_name],
                                  password: password
    if application.save
      render json: { message: 'created',
                     data: { api_name: params[:api_name],
                             api_key: application.password } },
             status: :created
    else
      render json: { message: application.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def authen_application
    @application = Application.find_by!(name: params[:api_name])
    return render json: { message: 'Authentication Failure' },
                  status: :unauthorized \
    unless @application.authenticate(params[:api_key])
  end

  private

  def random_password
    collection = [('a'..'z'), ('A'..'Z'), (0..9)].map(&:to_a).flatten
    (0...50).map { collection[rand(collection.length)] }.join
  end
end
