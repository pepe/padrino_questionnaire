class Sheet
  include Mongoid::Document
  include Mongoid::Timestamps # adds created_at and updated_at fields

  field :started_at, :type => Time
  field :finished_at, :type => Time
  field :frequency
  field :frequency_other
  field :purpose_fuel, :type => Integer
  field :purpose_relaxation, :type => Integer
  field :purpose_gathering, :type => Integer
  field :purpose_hobbitry, :type => Integer
  field :favorite_place
  field :time_spent, :type => Integer
  field :once_receive, :type => Integer
  field :once_payment, :type => Integer
  field :important_ground, :type => Integer
  field :important_nature, :type => Integer
  field :important_wood, :type => Integer
  field :important_gathering, :type => Integer
  field :important_water, :type => Integer
  field :important_climate, :type => Integer
  field :important_health, :type => Integer
  field :relation
  field :email
  field :note

  named_scope :finished, :where => {:finished_at.exists => true, :started_at.exists => true}, :order_by => 'finished_at'
  validates_numericality_of :once_payment, :allow_nil => true
  validates_numericality_of :once_receive, :allow_nil => true
  validates_numericality_of :time_spent, :allow_nil => true

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
      attribute = attribute.to_s
      {'min' => Sheet.min(attribute),
       'max' => Sheet.max(attribute),
       'avg' => Sheet.sum(attribute)/Sheet.count}
    end
  end

  # starts questionnaire
  def start
    self.started_at = Time.now
  end

  # finishs questionnaire
  def finish
    self.finished_at = Time.now
    self.save
  end
end
