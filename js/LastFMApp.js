// on page load

 $(window).load(function() {
	var apiKey = 'e2ee33a23a2c546f5b2c427f3c4912b4';
	var apiSecret = '2e25ea5cd8113d79c53892b29668819c';
    // define api keys
	var lastfm = new LastFM({
		apiKey: apiKey,
		apiSecret: apiSecret
	});
	

	
	$("#buttn").on("click", function(e){
		e.preventDefault();
		
		//track search
		if( $("#search").val() && $("#trackSearch").val() && !$("#albumSearch").val() ) {
			var trackInfo = lastfm.track.getInfo({
				track: $("#trackSearch").val(),
				artist: $("#search").val()},
				{success: function(data){
					/* Use data. */
					
					$('#infoResults').empty().append(
						 $('#lastfmTemplateTrackInfo').render(data.track)
					);
						
						
				}, error: function(data){
					/* Show error message. */
					alert(data.error + " " + data.message);
				}
			});		
		}
		//artist search
		if( $("#search").val() && !$("#trackSearch").val() && !$("#albumSearch").val() ){
			var artistInfo = lastfm.artist.getInfo({
				//limit: 3,
				artist: $("#search").val()},
				{success: function(data){
					/* Use data. */
					$('#infoResults').empty().append(
						 $('#lastfmTemplateArtistInfo').render(data.artist)
					);
 
				}, error: function(data){
					/* Show error message. */
					alert(data.error + " " + data.message);
				}
			});
			
			var aTopAlbums = lastfm.artist.getTopAlbums({
				limit: 5,
				artist: $("#search").val()},
				{success: function(data){
					//use data
					$('#topAlbumResults').empty().append(
						 $('#topAlbumsTemplate').render(data.topalbums)
						
					);

					
					
				},error: function(data){
					alert(data.error + " " + data.message);
				}
				
			});
			
		
		}
		//album search
		if( $("#search").val() && !$("#trackSearch").val() && $("#albumSearch").val() ){
			var albumInfo = lastfm.album.getInfo({
				artist: $("#search").val(),
				album: $("#albumSearch").val()},
				{success: function(data){
					/* Use data. */
					$('#infoResults').empty().append(
						 $('#lastfmTemplateAlbumInfo').render(data.album, 
						 {getMinute: function(duration){
							var minute = Math.floor(duration/60);
							return minute;
						 }
						 })
					);

				}, error: function(data){
					/* Show error message. */
					alert(data.error + " " + data.message);
				}
			});				
			
		}
		else{
		
		}
		
		
	});

});

















