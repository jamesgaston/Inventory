class ProvincesController < ApplicationController
  def show
  end

  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  def delete
  end

  def index
     @provinces = Province.order("country_id").order("name") 
  end

end
