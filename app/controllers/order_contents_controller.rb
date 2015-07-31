class OrderContentsController < ApplicationController

  def destroy
    OrderContent.find(params[:id]).destroy
    redirect_to URI(request.referer).path
  end

  def update_quantities
    params[:quantity].each_pair do |id, quant|
    	quant = 0 if quant.nil?
    	OrderContent.find(id).update(:quantity => quant.to_i)
    end
    # OrderContent.find(params[:id]).update(whitelisted_params)
  	redirect_to URI(request.referer).path
  end

  def add_items
    OrderContent.create(add_items_params)
    redirect_to URI(request.referer).path
  end

private

	# def whitelisted_params
	# 	params.require(:order_content).permit(:quantity)
	# end

	def add_items_params
		prod_id = params[:product_id]
  	quant = params[:quantity]
  	id = params[:order_id]
  	quant = 0 if quant.nil?
		{:quantity => quant.to_i, :product_id => prod_id, :order_id => id}
	end

end