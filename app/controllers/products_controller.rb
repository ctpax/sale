class ProductsController < ApplicationController
	respond_to :json, :html
	def index
		@imports = Product.party(params[:limit], params[:category], params[:search])
		respond_with @imports
	end

	def create
    @product = Product.create(params.require(:product).permit(:name, :price, :sale_price, :url, :imageurl, :brand, :list_id))
      redirect_to users_path
  end


end
