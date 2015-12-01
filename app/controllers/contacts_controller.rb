class ContactsController < ApplicationController
  def index
    if current_user
      @contacts = current_user.contacts
      
      group_name = params[:group]
      if group_name
        @contacts = Group
          .find_by(name: group_name)
          .contacts
          .where(user_id: current_user.id)
      end
    else
      flash[:info] = "You are logged out."
      redirect_to '/users/sign_in'
    end
  end

  def show
    @contact = Contact.find_by(id: params[:id])
  end

  def new
  end

  def create
    @contact = Contact.create(
      first_name: params[:first_name],
      last_name: params[:last_name],
      email: params[:email],
      phone: params[:phone],
      user_id: current_user.id
    )
    flash[:success] = "Contact created."
    redirect_to "/contacts/#{@contact.id}"
  end

  def edit
    @contact = Contact.find_by(id: params[:id])
  end

  def update
    @contact = Contact.find_by(id: params[:id])
    @contact.update(first_name: params[:first_name], last_name: params[:last_name], email: params[:email], phone: params[:phone])
    flash[:success] = "Contact updated."
    redirect_to "/contacts/#{@contact.id}"
  end

  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    flash[:success] = "Contact deleted."
    redirect_to "/"
  end
end
