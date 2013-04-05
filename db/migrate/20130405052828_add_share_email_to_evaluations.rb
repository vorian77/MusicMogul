class AddShareEmailToEvaluations < ActiveRecord::Migration
  def change
    add_column :evaluations, :share_email, :boolean, default: false
  end
end
