class Track::Trophies::General::ReadFiftyCommunitySolutionsTrophy < Track::Trophy
  def name(_) = "Inspiration"
  def icon = 'trophy-read-fifty-community-solutions'

  def criteria(track)
    "Awarded once you've read %<num_solutions>d community solutions in %<track_title>s" % {
      num_solutions: NUM_SOLUTIONS,
      track_title: track
    }
  end

  def success_message(track)
    "Congratulations on reading %<num_solutions>d community solutions in %<track_title>s" % {
      num_solutions: NUM_SOLUTIONS,
      track_title: track
    }
  end

  def award?(user, track)
    UserTrack::ViewedCommunitySolution.
      where(user:, track:).
      count >= NUM_SOLUTIONS
  end

  NUM_SOLUTIONS = 50
  private_constant :NUM_SOLUTIONS
end
