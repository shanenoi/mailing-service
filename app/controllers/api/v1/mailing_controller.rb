module Api::V1
  class MailingController < ApplicationController
    before_action :authen_application, only: %i[create]

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
      params.permit(
        *authen_params,
        :email,
        subject_params: {},
        content_params: {}
      )
    end
  end
end
