class ProductsController < ApplicationController
	respond_to :json, :html
	def index
		@imports = Product.party(params[:limit], params[:category], params[:search])
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
      format.html { redirect_to "#"}
      format.json { render json: { head: :ok } }
    end
  end 

   # <%= form_for :product, url: products_path do |f| %>
   #                          <%= collection_select :page, :list_id, current_user.lists, :id, :name %>
   #                          <%= f.hidden_field :name, :value => p["name"] %>
   #                          <%= f.hidden_field :price, :value => p['priceLabel'] %>
   #                          <%= f.hidden_field :sale_price, :value => p['salePriceLabel'] %>
   #                          <%= f.hidden_field :brand, :value => p['brand']['name']  %>
   #                          <%= f.hidden_field :url, :value => p['clickUrl'] %>
   #                          <%= f.hidden_field :image_url, :value => p['image']['sizes']['IPhone']['url'] %>
                        
   #                          <%= f.submit 'add products' %>
   #                        <% end %>

  
end
