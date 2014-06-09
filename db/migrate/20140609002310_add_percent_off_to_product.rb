class AddPercentOffToProduct < ActiveRecord::Migration
  def change
    add_column :products, :percent_off, :float
  end
end
