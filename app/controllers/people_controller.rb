class PeopleController < ApplicationController

before_action :find_person, only: %w(edit update show)

  def index
    @person = Person.all
  end

  def show
  end

  def new
    @person = Person.new
    @person.build_address
  end

  def edit
  end

  def create
    @person = Person.new person_params
    if @person.save
      flash[:notice] = "Person successfully added."
      redirect_to root_url
    else
      render "new"
    end
  end

  def update
    if @person.update person_params
      flash[:notice] = "Person successfully updated."
      redirect_to root_url
    else
      render "edit"
    end
  end

  def destroy
    Person.find(params[:id]).destroy
    flash[:notice] = "Person successfully deleted."
    redirect_to root_url
  end

  private

  def person_params
    params.require(:person).permit(:first_name, :last_name, :phone, address_attributes: [:street_address, :city, :state, :zip])
  end

  def find_person
    @person = Person.find(params[:id])
  end
end
