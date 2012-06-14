/*
 * MovingBoxes demo script
 */

$(function(){

	$('#slider-two').movingBoxes({
		startPanel   : 1,      // start with this panel
		reducedSize  : 0.8,    // non-current panel size: 80% of panel size
		buildNav     : true,   // if true, navigation links will be added
		navFormatter : function(index, panel){ return panel.find('h2 span').text(); } // function which gets nav text from span inside the panel header

		// width and panelWidth options removed in v2.2.2, but still backwards compatible
		// width        : 500,    // overall width of movingBoxes (not including navigation arrows)
		// panelWidth   : 0.7,    // current panel width

	});


	// Report events to firebug console
	$('.mb-slider').bind('initialized.movingBoxes initChange.movingBoxes beforeAnimation.movingBoxes completed.movingBoxes',function(e, slider, tar){
		// show object ID + event in the firebug console
		// namespaced events: e.g. e.type = "completed", e.namespace = "movingBoxes"
		if (window.console && window.console.log){
			var txt = slider.$el[0].id + ': ' + e.type + ', now on panel #' + slider.curPanel + ', targeted panel is ' + tar;
			console.log( txt );
		}
	});

});