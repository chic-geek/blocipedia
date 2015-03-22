class AlterWikisPrivateDefault < ActiveRecord::Migration
  def change
    change_column(:wikis, :private, :boolean, default: true)
    change_column_null(:wikis, :private, false, true)
    # false = column shouldn't be nullable,
    # true = the value updated to that is currently null.
  end
end
