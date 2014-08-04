class RenameVenueImportCsvsToVenueImports < ActiveRecord::Migration
  def change
    rename_table :venue_import_csvs, :venue_imports
  end

end
