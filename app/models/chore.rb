class Chore < ApplicationRecord
  belongs_to :child
  belongs_to :task

  scope :by_task, -> { joins(:task).order("name") }
  scope :chronological, -> { order(:due_on, :completed) }
  scope :pending, -> { where(completed: false) }
  scope :done, -> { where(completed: true) }
  scope :upcoming, -> { where("due_on >= ?", Date.current) }
  scope :past, -> { where("due_on < ?", Date.current) }

  validates_date :due_on

  def status 
    if completed == true
      return "Completed"
    else
      return "Pending"
    end
  end
end
