class AddPlanToLibraries < ActiveRecord::Migration[5.2]
  def change
  	add_column :libraries, :monthly_plan_id, :string
    add_column :libraries, :quaterly_plan_id, :string
    add_column :libraries, :halfyearly_plan_id, :string
    add_column :libraries, :yearly_plan_id, :string
  end
end
