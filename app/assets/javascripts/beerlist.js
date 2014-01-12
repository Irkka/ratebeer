var BEERS = {};

//BEERS.show = function() {
//var beer_list = [];

//$.each(BEERS.list, function (index, beer) {
//beer_list.push('<li>' + beer['name'] + '</li>')
//});

//$("#beers").html('<ul>' + beer_list.join('') + '</ul>');
//};

BEERS.show = function() {
		$("#beertable tr:gt(0)").remove()

		var table = $("#beertable");

		$.each(BEERS.list, function (index, beer) {
				table.append('<tr>'
										 +'<td>'+beer['name']+'</td>'
										 +'<td>'+beer['style']['name']+'</td>'
										 +'<td>'+beer['brewery']['name']+'</td>'
										 +'</tr>');
		});
};

BEERS.reverse = function() {
		BEERS.list.reverse();
};

BEERS.sort_by_name = function(){
		BEERS.list.sort( function(a,b){
				return a.name.toUpperCase() > b.name.toUpperCase();
		});
};

BEERS.sort_by_style = function(){
		BEERS.list.sort( function(a,b){
				return a.style.name.toUpperCase() > (b.style.name.toUpperCase());
		});
};

BEERS.sort_by_brewery = function(){
		BEERS.list.sort( function(a,b){
				return a.brewery.name.toUpperCase() > (b.brewery.name.toUpperCase());
		});
};

$(document).ready(function () {
		$("#reverse").click(function (e) {
				BEERS.reverse();
				BEERS.show();
				e.preventDefault();
		});

		if ( $("#beertable").length>0) {
				$.getJSON('beers.json', function (beers) {
						BEERS.list = beers;
						BEERS.show();
				});
		};

		$("#name").click(function (e) {
				BEERS.sort_by_name();
				BEERS.show();
				e.preventDefault();
		});

		$("#style").click(function (e) {
				BEERS.sort_by_style();
				BEERS.show();
				e.preventDefault();
		});

		$("#brewery").click(function (e) {
				BEERS.sort_by_brewery();
				BEERS.show();
				e.preventDefault();
		});	
});
