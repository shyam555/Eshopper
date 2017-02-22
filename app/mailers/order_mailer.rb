class OrderMailer < ApplicationMailer
  default from: 'shyamshinde555@gmail.com'
 
  def order_email(address,orderitems)

    @address = address
    @orderitems = orderitems
    @url  = 'http://example.com/login'
    attachments.inline['logo.png'] = File.read('app/assets/images/home/logo.png')
    mail(to:@address.email , subject: 'Order successfully placed.')
  end
end
