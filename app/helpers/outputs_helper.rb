Padquest.helpers do
  def occurence_and_percents(stat)
    res = ''
    @stats[stat].each_pair do |key, value|
       unless key == :all
         res << "<li>%s: %s (%s%%)</li>\n" % 
           [key, value, ((value/@stats[stat][:all].to_f) * 100 + 0.5).floor]
       end
    end
    return res
  end
end
