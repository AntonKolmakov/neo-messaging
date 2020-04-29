class MessagesController < ApplicationController
  def index
    @messages = User.current.inbox.messages.page(params[:page]).per(10)
  end

  def new
    @message = Message.new
  end

  def show
    @message = Message.find(params[:id])
  end

  def create
    @message = User.current.outbox.messages.build(messages_params)
    if @message.save
      redirect_to messages_path
    else
      render :new
    end
  end

  private

  def messages_params
    params.require(:message).permit(:body).merge(inbox_id: User.default_doctor.id)
  end
end
