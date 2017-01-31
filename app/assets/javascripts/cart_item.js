function updateQuantity(cart_item_id,cart_item_product_id) {

    var quantity = document.getElementById(cart_item_id).value;
    //var id = $('#cart_item_id').attr('id');
    // alert("Input field lost focus."+ quantity);
    $.ajax({
              type: 'PUT',
              url: '/cart_items/'+cart_item_id,
              data: {"quantity" :quantity},
              dataType : 'script',
              success: function() {
                $('#cart_item_id').html('hi')
               } 
              
          });
}