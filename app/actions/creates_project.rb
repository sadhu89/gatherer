class CreatesProject
  attr_accessor :name, :task_string, :project
  def initialize(name: "", task_string: "")
    @name = name
    @task_string = task_string
  end
  def build 
    self.project = Project.new name:name
    project.tasks = convert_string_to_tasks
    project
  end

  def create
    build
    project.save!
  end

  def convert_string_to_tasks
    tasks = []
    if task_string.present?
      task_string.split("\n").each do |task_string_line|
        title, size = task_string_line.split(":")
        size ||= 1
        tasks << Task.new(title: title, size: size) 
      end
    end
    tasks
  end
end