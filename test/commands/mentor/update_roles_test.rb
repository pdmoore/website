require "test_helper"

class Mentor::UpdateRolesTest < ActiveSupport::TestCase
  test "adds or removes supermentor role depending on criteria being met" do
    user = create :user, became_mentor_at: nil, roles: []

    Mentor::UpdateRoles.(user)
    refute user.reload.supermentor? # Not yet a mentor

    user.update(became_mentor_at: Time.current)
    Mentor::UpdateRoles.(user)
    refute user.reload.supermentor? # Mentor but criteria not met

    # Num finished mentoring sessions and satisfaction percentage are too low
    user.update(mentor_satisfaction_percentage: 94)
    Mentor::UpdateRoles.(user)
    refute user.reload.supermentor?

    99.times do
      create :mentor_discussion, :student_finished, mentor: user
    end

    # Too few finished mentoring sessions
    user.update(mentor_satisfaction_percentage: 95)
    Mentor::UpdateRoles.(user)
    refute user.reload.supermentor?

    # Only mentor discussions finished by student count
    create :mentor_discussion, :awaiting_mentor, mentor: user
    create :mentor_discussion, :awaiting_student, mentor: user
    create :mentor_discussion, :mentor_finished, mentor: user
    Mentor::UpdateRoles.(user)
    refute user.reload.supermentor?

    create :mentor_discussion, :student_finished, mentor: user
    Mentor::UpdateRoles.(user)
    assert user.reload.supermentor?

    # Satisfaction percentage is not set
    user.update(mentor_satisfaction_percentage: nil)
    Mentor::UpdateRoles.(user)
    refute user.reload.supermentor?

    # Satisfaction percentage is too low
    user.update(mentor_satisfaction_percentage: 94)
    Mentor::UpdateRoles.(user)
    refute user.reload.supermentor?
  end
end