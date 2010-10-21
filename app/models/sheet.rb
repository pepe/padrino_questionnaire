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
      result[:all] = Sheet.only(attribute).aggregate.inject(0) do |all, pair|
        result[pair[attribute]] = pair['count'].to_i
        all += pair['count'].to_i
      end
      
      return result
    end

    def minmax_for(attribute)
      attribute = attribute.to_sym
      all = Sheet.only(attribute)
      all = all.map{|s| s.send(attribute).to_i}.select {|value| value > 0}
      min, max = all.minmax
      {'min' => min,
       'max' => max,
       'avg' => all.reduce(:+) / all.size}
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
end
