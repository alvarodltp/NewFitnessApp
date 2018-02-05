class WorkoutController < ApplicationController
  before_action :set_workouts

  def set_workouts
    @workouts = {
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

    @workouts.each do |workout, groups|
      if (groups & exclude_muscle_groups).empty?
        @resulting_workouts.push(workout)
      end
    end
  end

  def results

    workout = params[:workout].to_sym
    muscle_groups = @workouts[workout]
    @workout_name = @workout_names[workout]

    if workout == :full_body
      @exercises = Exercise.all.order('RAND()').limit(8)

    else
      @exercises = Exercise.where(muscle_group: muscle_groups, high_intensity: false).order('RAND()').limit(6)

    end
  end
end
