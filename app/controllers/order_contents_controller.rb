class OrderContentsController < ApplicationController

  def destroy
    OrderContent.find(params[:id]).destroy
    redirect_to URI(request.referer).path

  end

end