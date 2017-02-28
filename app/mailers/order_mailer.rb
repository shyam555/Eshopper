class OrderMailer < ApplicationMailer
  default from: 'eshopper@admin.com'
 
  def order_email(address,orderitems,session,current_user)

    @address = address
    @orderitems = orderitems
    @session = session
    @current_user = current_user

    @cart_items = @current_user.cart_items.all
    @sub_total = 0
    @discount = 0
    @cart_items.each do |item|

      @sub_total += (item.product.price.to_i * item.quantity.to_i) 
    end
    if @session.present?
      @coupon = Coupon.find_by(code: @session)
      @percent_off = @coupon.percent_off
      @discount = ((@percent_off * @sub_total) / 100)
      @tax = 0.04 * @sub_total
      @shipping_charges = 40 
      @final_total = @tax + @sub_total + @shipping_charges - @discount
    else
      @tax = 0.04 * @sub_total
      @shipping_charges = 40
      @final_total = @tax + @sub_total + @shipping_charges
    end

    @url  = 'http://example.com/login'
    attachments.inline['logo.png'] = File.read('app/assets/images/home/logo.png')
    mail(to:@address.email , subject: 'Order successfully placed.')
  end
end
