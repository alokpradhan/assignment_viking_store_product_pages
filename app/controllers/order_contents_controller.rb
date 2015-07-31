class OrderContentsController < ApplicationController

  def destroy
    OrderContent.find(params[:id]).destroy
    redirect_to URI(request.referer).path
  end

  def update
  	OrderContent.find(params[:id]).update(whitelisted_params)
  	redirect_to URI(request.referer).path
  end

private

	def whitelisted_params
		params.require(:order_content).permit(:quantity)
	end

end