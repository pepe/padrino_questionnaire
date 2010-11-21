# Helper methods defined here can be accessed in any controller or view in the application

Padquest.helpers do
  def occurence_and_percents(stat)
    res = ''
    #TODO move to model generating array of arrays
    @stats[stat].each_pair do |key, value|
       unless key == :all
         res << "<li>%s: %s (%s%%)</li>\n" % 
           [key, value, ((value/@stats[stat][:all].to_f) * 100 + 0.5).floor]
       end
    end
    return res
  end
end
