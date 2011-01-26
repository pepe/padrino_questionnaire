class Sheet
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :started_at, :type => Time
  field :finished_at, :type => Time
  field :frequency
  field :frequency_other
  field :purpose_fuel
  field :purpose_relaxation
  field :purpose_gathering
  field :purpose_hobbitry
  field :favorite_place
  field :time_spent
  field :once_receive
  field :once_payment
  field :important_ground
  field :important_nature
  field :important_wood
  field :important_gathering
  field :important_water
  field :important_climate
  field :important_health
  field :relation
  field :email
  field :note

  named_scope :finished, :where => {:finished_at.exists => true, :started_at.exists => true}, :order_by => 'finished_at'

  class << self
    def start_new
      ret = new
      ret.start
      return ret
    end

    def sumas_for(attribute)
      attribute = attribute.to_s
      result = {}
      result[:all] = Sheet.finished.only(attribute).aggregate.inject(0) do |all, pair|
        result[pair[attribute]] = pair['count'].to_i
        all += pair['count'].to_i
      end

      return result
    end

    def minmax_for(attribute)
      attribute = attribute.to_sym
      all = Sheet.finished.only(attribute)
      all = all.map{|s| s.send(attribute).to_i}.select {|value| value > 0}
      min, max = all.minmax
      {'min' => min,
       'max' => max,
       'avg' => all.reduce(:+) / all.size}
    end

    # returns all stats as hash
    def all_stats
      @stats = {:frequency => sumas_for(:frequency),
                :purpose_relaxation => sumas_for(:purpose_relaxation),
                :purpose_fuel => sumas_for(:purpose_fuel),
                :purpose_gathering => sumas_for(:purpose_gathering),
                :purpose_hobbitry => sumas_for(:purpose_hobbitry),
                :important_wood => sumas_for(:important_wood),
                :important_nature => sumas_for(:important_nature),
                :important_ground => sumas_for(:important_ground),
                :important_climate => sumas_for(:important_climate),
                :important_gathering => sumas_for(:important_gathering),
                :important_health => sumas_for(:important_health),
                :important_water => sumas_for(:important_water),
                :relation => sumas_for(:relation),
                :time_spent => minmax_for(:time_spent),
                :once_payment => minmax_for(:once_payment),
                :once_receive => minmax_for(:once_receive)
      }
    end
  end

  # starts questionnaire
  def start
    self.started_at = Time.now
  end

  # finishes questionnaire
  def finish
    self.finished_at = Time.now
    self.save
  end

  # returns sheet as csv line
  def to_csv_line
   [id, started_at, finished_at, frequency, frequency_other, time_spent,
     purpose_gathering, purpose_hobbitry, purpose_fuel, purpose_relaxation,
     favorite_place, once_receive, once_payment, important_nature, important_wood,
     important_gathering, important_water, important_climate, important_health,
     important_ground, relation].map{|field| %("#{field}")}.join(';')
  end
end
