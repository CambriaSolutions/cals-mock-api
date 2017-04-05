module SearchHelper
  def prepare_indices
    Facility.__elasticsearch__.import force: true
    Facility.__elasticsearch__.create_index!
    sleep 3 #so that elastic search indexing finishes
  end
end
