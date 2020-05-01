class PaymentController < ApplicationController
  def create
    response = PaymentService.new(User.current).call

    if response[:success].present?
      flash[:success] = t('flash.success')
      redirect_to messages_path
    else
      flash[:danger] = t('flash.error', error: response[:error])
      redirect_to messages_path
    end
  end
end