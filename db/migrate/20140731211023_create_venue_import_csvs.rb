class CreateVenueImportCsvs < ActiveRecord::Migration
  def change
    create_table :venue_import_csvs do |t|
      t.text :content

      t.timestamps
    end
  end
end
