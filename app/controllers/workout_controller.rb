class WorkoutController < ApplicationController
  before_action :set_body_parts

  def set_body_parts
    @body_parts = {
        chest_triceps: ['Chest', 'Triceps'],
        back_biceps: ['Back', 'Biceps'],
        shoulders_abs: ['Shoulders', 'Abs'],
        chest: ['Chest'],
        back: ['Back'],
        arms: ['Arms'],
        shoulders: ['Shoulders'],
        abs: ['Abs'],
        legs: ['Legs'],
        full_body: ['Full Body'],
    }

    @workout_names = {
        chest_triceps: "Chest & Triceps",
        back_biceps: "Back & Biceps",
        shoulders_abs: "Shoulders & Abs",
        chest: "Chest",
        back: "Back",
        arms: "Arms",
        shoulders: "Shoulders",
        abs: "Abs",
        legs: "Legs",
        full_body: "Full Body",
    }
  end

  def index
    @dropdown_options = [
        ["I didn't workout", :no_workout],
        ["Chest & Triceps", :chest_triceps],
        ["Back & Biceps", :back_biceps],
        ["Shoulders & Abs", :shoulders_abs],
        ["Chest", :chest],
        ["Back", :back],
        ["Shoulders", :shoulders],
        ["Abs", :abs],
        ["Legs", :legs],
        ["Full Body", :full_body],
    ]
  end

  def options
    exclusions = {
        no_workout: [],
        chest_triceps: ['Chest', 'Triceps'],
        back_biceps: ['Back', 'Biceps'],
        shoulders_abs: ['Shoulders', 'Abs'],
        chest: ['Chest'],
        back: ['Back'],
        arms: ['Arms'],
        shoulders: ['Shoulders'],
        abs: ['Abs'],
        legs: ['Legs'],
        full_body: ['Full Body'],
    }

    exclude_muscle_groups = exclusions[params[:workout_1].to_sym] | exclusions[params[:workout_2].to_sym]

    @resulting_workouts = []

    @body_parts.each do |body_parts, groups|
      if (groups & exclude_muscle_groups).empty?
        @resulting_workouts.push(body_parts)
      end
    end
  end

  def results
    workout = params[:workout].to_sym
    muscle_groups = @body_parts[workout]
    @workout_name = @workout_names[workout]

    if workout == :full_body
      @exercices = Exercise.all.order('RANDOM()').limit(8)

    else
      @exercises = Exercise.where(muscle_group: muscle_groups, high_intensity: false).order('RANDOM()').limit(6)

    end
  end
end
