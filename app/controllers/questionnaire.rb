Padquest.controllers :questionnaire do
  helpers do
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
end
