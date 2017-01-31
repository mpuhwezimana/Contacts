class ContactsController < ApplicationController
  
  def index
    @contacts = Contact.all
  end

  def show
    @contact = Contact.find_by(id: params[:id])
  end

  def new
  end 

  def create
    name = params[:name]
    email = params[:email]
    phone = params[:phone]
    address = params[:address]
    image = params[:image]
    contact = Contact.new({name: name, email: email, phone: phone, address: address,image: image  })
    contact.save
    redirect_to "/contacts/#{contact.id}" 
    flash[:success]= "Contact created"
  end 

  def edit
    @contacts = Contact.find_by(id: params[:id])
  end 

  def update
    contact = Contact.find_by(id: params[:id])
    contact.name = params[:name]
    contact.email = params[:email]
    contact.phone = params[:phone]
    contact.address = params[:address]
    contact.image = params[:image]
    contact.save
    redirect_to "/contacts/#{contact.id}"
    flash[:info]= "Contact updated"
  end
  def destroy
    @contact = Contact.find_by(id: params[:id])
    @contact.destroy
    redirect_to "/contacts"
    flash[:warning]= "Contact destroyed"
  end
  def search
    search_query = params[:search_input]
    @contacts = Contact.where("name LIKE ? OR email LIKE ?, OR address LIKE ?", "%#{search_query}%", "%#{search_query}%", "%#{search_query}%")

    render :index
  end
end