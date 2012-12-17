jQuery(document).ready(function() {
	$('#countdown_dashboard').countDown({
		targetDate: {
			'day': 		30,
			'month': 	12,
			'year': 	2012,
			'hour': 	00,
			'min': 		0,
			'sec': 		0
		}
	});
});
