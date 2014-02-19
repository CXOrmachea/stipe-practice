class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.string :email
      t.string :guid
      t.references :product

      t.timestamps
    end
    add_index :sales, :product_id
  end
end
