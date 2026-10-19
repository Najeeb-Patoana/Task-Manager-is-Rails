
class Task < ApplicationRecord
  # Callback: runs before model validations
  before_validation :normalize_title

  # Callback: runs after a successful create operation
  after_create :log_task_creation

  # Callback: runs before updating an existing record
  before_update :log_task_update

  # Validations
  validates :title, presence: true,
                    length: { minimum: 3, maximum: 100 }

  validates :description, length: { maximum: 1000 },
                          allow_blank: true

  validates :status, inclusion: {
    in: %w[pending completed]
  }

  validate :due_date_cannot_be_in_the_past

  private

  def normalize_title
    self.title = title.strip if title.present?
  end

  def log_task_creation
    Rails.logger.info("Task created: #{id} - #{title}")
  end

  def log_task_update
    Rails.logger.info("Updating task: #{id}")
  end

  def due_date_cannot_be_in_the_past
    return if due_date.blank?

    if due_date < Date.current
      errors.add(:due_date, "cannot be in the past")
    end
  end
end
