module SearchHelper
  def prepare_indices
    Facility.__elasticsearch__.import force: true
    Facility.__elasticsearch__.create_index!
    Facility.__elasticsearch__.refresh_index!
    sleep 1 #so that elastic search indexing finishes
  end
end
