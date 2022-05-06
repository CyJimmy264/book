class AddFingerprintToUsers < ActiveRecord::Migration[7.0]
  def self.up
    change_table :users do |t|
      t.string :fingerprint
    end
  end
end
