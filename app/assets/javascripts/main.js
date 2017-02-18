/*price range*/

 $('#sl2').slider();

	var RGBChange = function() {
	  $('#RGB').css('background', 'rgb('+r.getValue()+','+g.getValue()+','+b.getValue()+')')
	};
function showImage(image_path){
  $("#show").attr("src",image_path)

}	
/*scroll to top*/
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
 $(document).ready(function(){
 	$("#cart_item_id").change(function(){
         alert("Input field lost focus."+ quantity);
     });
 });
 
$(document).ready(function(){
    $('[data-toggle="popover"]').popover();   
});


$(document).ready(function(){
	$(function () {
		$.scrollUp({
	        scrollName: 'scrollUp', // Element ID
	        scrollDistance: 300, // Distance from top/bottom before showing element (px)
	        scrollFrom: 'top', // 'top' or 'bottom'
	        scrollSpeed: 300, // Speed back to top (ms)
	        easingType: 'linear', // Scroll to top easing (see http://easings.net/)
	        animation: 'fade', // Fade, slide, none
	        animationSpeed: 200, // Animation in speed (ms)
	        scrollTrigger: false, // Set a custom triggering element. Can be an HTML string or jQuery object
					//scrollTarget: false, // Set a custom target element for scrolling to the top
	        scrollText: '<i class="fa fa-angle-up"></i>', // Text for element, can contain HTML
	        scrollTitle: false, // Set a custom <a> title if required.
	        scrollImg: false, // Set true to use image
	        activeOverlay: false, // Set CSS color to display scrollUp active point, e.g '#00FFFF'
	        zIndex: 2147483647 // Z-Index for the overlay
		});
	});
});
