class AddRecordSignaturesAssociation < ActiveRecord::Migration[7.0]
  def change
    change_table :records do |t|
      t.references :signed_record, foreign_key: { to_table: :records }
    end
  end
end
