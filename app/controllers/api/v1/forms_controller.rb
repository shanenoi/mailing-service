class Api::V1::FormsController < ApplicationController
  before_action :authen_application
  before_action :set_api_v1_form, only: [:show, :update, :destroy]

  def index
    forms = MailForm.all
    render json: forms
  end

  def show
    render json: @form
  end

  def create
    form = MailForm.new(form_params.merge( application_id: @application.id))
    if form.save
      render json: { message: 'created' },
             status: :created
    else
      render json: { message: form.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    if @form.update(form_params)
      render json: @form
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  def destroy
    if @form.destroy
      render json: { message: 'deleted' }
    else
      render json: @form.errors, status: :unprocessable_entity
    end
  end

  private
    def set_api_v1_form
      @form = MailForm.find(params[:id])
    end

    def form_params
      params.require(:form).permit(%i[name subject content])
    end
end
