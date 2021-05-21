$(document).ready(function(){
	
	//------------------------------------------------------------------------------------------------
	// Menu
	$('#menu').hide();
	$('#menu-button').mousedown(
	function(e) {
		if ($('#menu').is(':hidden')) {
			$('#menu').fadeIn();
		}else{
			$('#menu').fadeOut();
		}
	});

	$('#power-button').mousedown(
	function(e) {
		$('#menu').fadeOut();
	});
	
	$('#terminal-button').mousedown(
	function(e) {
		$('#menu').fadeOut();
	});
	
	$('#expand-button').mousedown(
	function(e) {
		$('#menu').fadeOut();
	});
	
/*	var drawClock = function()
	{
		$('.box-clock').load('get_time.php', function() {
		});
	}
	
	drawClock();
	
	var auto_refresh_normal = setInterval(
		function()
		{
			drawClock();
		}, 10000
	);
*/

})