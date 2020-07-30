class PersonsController < ApplicationController
  protect_from_forgery :except => [:update]
  def index
    @persons = Person.all
  end

  def import
    Person.import(params[:file])
    redirect_to :action => "index", notice: "Persons data imported !"
  end

  def update
    @person = Person.find_by_reference(params[:reference])
    if @person.update(person_params)
      render json: @person, status: :ok
    else
      render json: @person.errors, status: :unprocessable_entity
    end
  end
  
  private
    def person_params
      params.require(:person).permit(:firstname, :lastname, :home_phone_number, :mobile_phone_number, :email, :address)
    end
end
