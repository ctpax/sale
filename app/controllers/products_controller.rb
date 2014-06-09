class ProductsController < ApplicationController
	respond_to :json, :html
	def index

    #request shopsense api through model method, store response in @import variable 

		@imports = Product.party(params[:search], params[:category], params[:limit])
		respond_with @imports
	end

	def create
    @product = Product.create(params.require(:product).permit(:name, :price, :sale_price, :url, :image_url, :brand, :list_id))
      redirect_to users_path
  end


  def destroy
    @product = Product.find(params[:id])
    @product.destroy
    respond_to do |format|
      format.html { redirect_to users_path }
      format.json { render json: { head: :ok } }
    end
  end   
end
