Padquest.helpers do
  # returns options for select
  def num_options(count = 5)
    ['---'] + (1..5).to_a.reverse
  end
end
