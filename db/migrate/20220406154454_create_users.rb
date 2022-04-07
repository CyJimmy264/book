class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.text :public_key

      t.timestamps
    end
  end
end
