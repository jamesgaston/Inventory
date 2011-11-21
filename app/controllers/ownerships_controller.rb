class OwnershipsController < ApplicationController
  def new
  end

  def edit
  end

  def destroy
  end

  def show
  end

 def index
    @ownerships = Ownership.order("name") 
  end

  def create
  end

  def update
  end

end
