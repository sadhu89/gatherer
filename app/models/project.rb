class Project < ActiveRecord::Base
  has_many :tasks

  def incomplete_tasks
    tasks.to_a.reject(&:complete?)
  end
  def done?
    incomplete_tasks.empty?
  end
  def total_size
    tasks.to_a.sum(&:size)
  end
  def remaining_size
    incomplete_tasks.sum(&:size)
  end

  def completed_velocity
    tasks.to_a.sum(&:points_toward_velocity)
  end

  def current_rate
    completed_velocity/Project.velocity_length_in_days.to_f
  end

  def projected_days_remaining
    remaining_size/current_rate
  end

  def on_schedule?
    return false if projected_days_remaining.nan?
    projected_days_remaining.days.from_now <= due_date
  end

  def self.velocity_length_in_days
    21
  end
end