class AddSha3ToRecords < ActiveRecord::Migration[7.0]
  def change
    change_table :records do |t|
      t.string :sha3
    end
  end
end
