Padquest.controllers :outputs do
  get :print, :map => '/print/:uid' do 
    @sheet = Sheet.find(params[:uid])
    render 'outputs/print'
  end

  get :list, :map => '/list' do
    @sheets = Sheet.finished
    render 'outputs/list'
  end

  get :stats, :map => '/stats' do
    @stats = Sheet.all_stats
    render 'outputs/stats'
  end

  get :csv_list, :map => '/list.csv' do
    headers['Content-type'] = 'text/csv;charset=utf-8'
    @sheets = Sheet.all
    render 'outputs/csv', :layout => false
  end
end
