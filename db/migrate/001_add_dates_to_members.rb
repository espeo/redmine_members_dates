class AddDatesToMembers < ActiveRecord::Migration
  def change
    add_column :members, :starts_on, :date
    add_column :members, :ends_on, :date
  end
end
