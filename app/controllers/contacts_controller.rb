class ContactsController < ApplicationController
	  	def new
	    	@contact = Contact.new
	  	end

		 def create
		  	begin
			    @contact = Contact.new(contacts_params)
			    @contact.request = request
			    if @contact.deliver
			      flash.now[:notice] = 'Thank you for your message. We will contact you soon!'
			    else
			      render :new
			    end
			rescue ScriptError 
				flash[:error] = 'Sorry, this message appears to be spam and was not delivered.' 
		  	end
		end
		def contacts_params
			params.require(:contact).permit(:name, :email, :message)
		end
end
