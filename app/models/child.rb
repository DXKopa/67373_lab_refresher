class Child < ApplicationRecord
  has_many :chores
  has_many :tasks, through: :chores

  validates_presence_of :first_name
  validates_presence_of :last_name

  def name
    return "#{self.first_name} #{self.last_name}"
  end

  scope :alphabetical, -> { order(:last_name).order(:first_name) }
  scope :active, -> { where(active: true) }

  def points_earned
    self.chores.done.inject(0){|sum,chore| sum += chore.task.points}
  end 
end
