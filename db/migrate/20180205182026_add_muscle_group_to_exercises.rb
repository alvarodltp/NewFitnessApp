class AddMuscleGroupToExercises < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :muscle_group, :string
  end
end
