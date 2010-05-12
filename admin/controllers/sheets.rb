Admin.controllers :sheets do

  get :index do
    @sheets = Sheet.all
    render 'sheets/index'
  end

  get :new do
    @sheet = Sheet.new
    render 'sheets/new'
  end

  post :create do
    @sheet = Sheet.new(params[:sheet])
    if @sheet.save
      flash[:notice] = 'Sheet was successfully created.'
      redirect url(:sheets, :edit, :id => @sheet.id)
    else
      render 'sheets/new'
    end
  end

  get :edit, :with => :id do
    @sheet = Sheet.find(params[:id])
    render 'sheets/edit'
  end

  put :update, :with => :id do
    @sheet = Sheet.find(params[:id])
    if @sheet.update_attributes(params[:sheet])
      flash[:notice] = 'Sheet was successfully updated.'
      redirect url(:sheets, :edit, :id => @sheet.id)
    else
      render 'sheets/edit'
    end
  end

  delete :destroy, :with => :id do
    sheet = Sheet.find(params[:id])
    if sheet.destroy
      flash[:notice] = 'Sheet was successfully destroyed.'
    else
      flash[:error] = 'Impossible destroy Sheet!'
    end
    redirect url(:sheets, :index)
  end

  get :finished do
    @sheets = Sheet.finished
    @title = "%s %s" % [pat(:finished), mt(:sheet)]
    render 'sheets/index'
  end
end
