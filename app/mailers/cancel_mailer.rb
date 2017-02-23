class CancelMailer < ApplicationMailer
  default from: 'shyamshinde555@gmail.com'
 
  def cancel_order(order,address)

    @order = order
    @address = address
    attachments.inline['logo.png'] = File.read('app/assets/images/home/logo.png')
    mail(to:@address.email , subject: 'Order successfully Cancalled.')
  end

  def reply_mailer(contact)
    @contact = contact
    attachments.inline['logo.png'] = File.read('app/assets/images/home/logo.png')
    mail(to:@contact.email , subject: 'Response')
  end
end
