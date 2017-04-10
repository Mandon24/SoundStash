// Your use of the YouTube API must comply with the Terms of Service:
// https://developers.google.com/youtube/terms

function tplawesome(e,t){res=e;for(var n=0;n<t.length;n++){res=res.replace(/\{\{(.*?)\}\}/g,function(e,r){return t[n][r]})}return res}


// Called automatically when JavaScript client library is loaded.
function onClientLoad() {
	gapi.client.setApiKey('AIzaSyCYECeoti8Pxm4n9fhEuhT4pUxnE3wmb1Y');
    gapi.client.load('youtube', 'v3', function(){
		//youtube api is ready
	});
}

$(function(){
	$("#buttn").on("click", function(e){
		e.preventDefault();
		// Use the JavaScript client library to create a search.list() API call.
		
		if( $("#search").val() || $("#search").val() && $("#trackSearch").val() ) {
		
			//show headers
			$('#headerOne').empty().append(
				"Music Info"
			);
			$('#headerTwo').empty().append(
				"Music Video"
			);
			
			var request = gapi.client.youtube.search.list({
				part: "snippet",
				type: "video",
				q: encodeURIComponent($("#search").val() + $("#trackSearch").val()).replace(/%20/g, "+"),
				maxResults: 1,
				order: "viewCount"
			});
			// Send the request to the API server,
			// and invoke fucntion(repsonse) with the response.
			request.execute(function(response){
				var results = response.result;
				$("#blankline").html(
						"<p>&nbsp; <p> &nbsp;</p>"
				);
				$.each(results.items, function(index, item){

					$.get("item.html", function(data) {

						$("#results").empty().append(
							
							tplawesome(data, [{"title":item.snippet.title, "videoid":item.id.videoId}])
							
							 
						);
					});				
				});
				resetVideoHeight();
			
			});
		
		}
	
	});
	
	$(window).on("resize", resetVideoHeight);
    
});

function resetVideoHeight() {
    $(".video").css("height", $("#results").width() * 9/16);
}
