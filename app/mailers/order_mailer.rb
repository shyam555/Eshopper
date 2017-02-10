class OrderMailer < ApplicationMailer
  default from: 'shyamshinde555@gmail.com'
 
  def order_email(address,orderitems)

    @address = address
    #@order = order
    @orderitems = orderitems
    @url  = 'http://example.com/login'
    mail(to:@address.email , subject: 'Order successfully placed.')
  end
end
