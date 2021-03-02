class AttachmentsController < ApplicationController

  def destroy
    @attach = ActiveStorage::Attachments.find(params[:id])
    @attach&.purge if current_user.author?(@attach.record)
  end
end
