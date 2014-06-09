class ChangeSalePriceTypeInProduct < ActiveRecord::Migration
  def change
  	change_column :products, :sale_price, :string
  end
end
