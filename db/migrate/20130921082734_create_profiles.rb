class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :first_name
      t.string :last_name
      t.string :occupation
      t.string :path_file
      t.belongs_to :user

      t.timestamps
    end
  end
end
