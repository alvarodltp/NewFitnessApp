class AddHighIntensityToExercises < ActiveRecord::Migration[5.1]
  def change
    add_column :exercises, :high_intensity, :boolean
  end
end
