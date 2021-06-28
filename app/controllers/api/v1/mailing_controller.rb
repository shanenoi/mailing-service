module Api::V1
  class MailingController < ApplicationController
    before_action :set_account, only: %i[create form]

    def set_account
      @application = Application.find_by!(name: params[:api_name])
      return render json: 'Authentication Failure',
                    status: :unauthorized unless @application.authenticate(params[:api_key])
    end

    def account
      application = Application.new(name: params[:api_name], password: params[:api_key])
      if application.save
        render json: { message: 'created' },
               status: :created
      else
        render json: { message: application.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def form
      _form = MailForm.new(
        name: params[:form_name],
        subject: params[:subject],
        content: params[:content],
        application_id: @application.id
      )
      if _form.save
        render json: { message: 'created' },
               status: :created
      else
        render json: { message: _form.errors.full_messages },
               status: :unprocessable_entity
      end
    end

    def create
      form = MailForm.find_by!(name: params[:form_name])
      NotificationMailer.notification(
        id: form.id,
        email: mail_delivery_params[:email],
        subject: mail_delivery_params[:subject_params].to_h,
        content: mail_delivery_params[:content_params].to_h,
      ).deliver_now
      
      render json: { message: 'sent!' },
             status: :created
    end

    private

    def mail_delivery_params
      params.permit(*authen_params, :email, subject_params: {}, content_params: {})
    end
  end
end
