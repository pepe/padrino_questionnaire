Padquest.controllers :questionnaire do
  helpers do
    def occurence_and_percents(stat)
      res = ''
      @stats[stat].each_pair {|key, value|
         unless key == :all
           res << "<li>%s: %s (%s%%)</li>\n" % 
             [key, value, (value/@stats[stat][:all].to_f) *100]
         end
      }
      return res
    end
    # returns options for select
    def num_options(count = 5)
      ['---'] + (1..5).to_a.reverse
    end
  end

  get :index, :map => "/" do
    sheet = Sheet.start_new
    sheet.save
    @uid = sheet.id
    render 'questionnaire/index'
  end

  get :first_part, :map => '/first_part/:uid' do
    @sheet = Sheet.find(params[:uid])
    render 'questionnaire/first_part'
  end

  post :save_first, :map => '/save_first/:uid' do
    @sheet = Sheet.find(params[:uid])
    @sheet.update_attributes(params[:sheet])
    redirect "/second_part/#{params[:uid]}"
  end

  get :second_part, :map => '/second_part/:uid' do
    @sheet = Sheet.find(params[:uid])
    render 'questionnaire/second_part'
  end

  post :save_second, :map => '/save_second/:uid' do
    @sheet = Sheet.find(params[:uid])
    @sheet.update_attributes(params[:sheet])
    @sheet.finish
    redirect "/thanks/#{params[:uid]}"
  end
  
  get :thanks, :map => '/thanks/:uid' do
    @sheet = Sheet.find(params[:uid])
    render 'questionnaire/thanks'
  end

  post :save_final, :map => '/save_final/:uid' do
    @sheet = Sheet.find(params[:uid])
    @sheet.update_attributes(params['questionnaire'])
    redirect '/'
  end

  get :print, :map => '/print/:uid' do 
    @sheet = Sheet.find(params[:uid])
    render 'questionnaire/print'
  end

  get :list, :map => '/list' do
    @sheets = Sheet.finished
    render 'questionnaire/list'
  end
  
  get :stats, :map => '/stats' do
    #FIXME move model method all_stats
    @stats = {:frequency => Sheet.sumas_for(:frequency),
              :purpose_relaxation => Sheet.sumas_for(:purpose_relaxation),
              :purpose_fuel => Sheet.sumas_for(:purpose_fuel),
              :purpose_gathering => Sheet.sumas_for(:purpose_gathering),
              :purpose_hobbitry => Sheet.sumas_for(:purpose_hobbitry),
              :important_wood => Sheet.sumas_for(:important_wood),
              :important_nature => Sheet.sumas_for(:important_nature),
              :important_ground => Sheet.sumas_for(:important_ground),
              :important_climate => Sheet.sumas_for(:important_climate),
              :important_gathering => Sheet.sumas_for(:important_gathering),
              :important_health => Sheet.sumas_for(:important_health),
              :important_water => Sheet.sumas_for(:important_water),
              :relation => Sheet.sumas_for(:relation),
              :time_spent => Sheet.minmax_for(:time_spent),
              :once_payment => Sheet.minmax_for(:once_payment),
              :once_receive => Sheet.minmax_for(:once_receive) 
    }
    render 'questionnaire/stats'
  end
  
end
