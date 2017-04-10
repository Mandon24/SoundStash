<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>


<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">



<html>
	<head>
		<title>SoundStash Youtube Video Seach Engine</title>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="description" content="SoundStash Videos!" />
		<!-- Links -->
		<link type="text/css" rel="stylesheet" href="stylesheet.css"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Lato"/>
		<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Arvo"/>
		
		<!-- Create Template for Artist Info -->
		<script id="lastfmTemplateArtistInfo" type="text/x-jsrender">
			<div class="artist_info">
				<a class="charts" href="{{:url}}" rel="nofollow" target="_blank"><b>{{:name}}: </b><img src="{{:image[2]['#text']}}" alt="{{:name}}" /></a>
				<div><noindex>
					{{:bio.content}}
				</noindex></div>
			</div>
		</script>
		
		<!-- Create Template for Track Info -->
		<script id="lastfmTemplateTrackInfo" type="text/x-jsrender">
			<div class="track_info">
				<p><b>Song: </b>{{:name}}</p>
				<p><b>Artist: </b>{{:artist.name}}</p>
				<div><noindex>
				{{if wiki.content}}
					{{:wiki.content}}
				{{else}}
					<p>No Content</p>
				{{/if}}
				</noindex></div>
			</div>
		</script>	

		<!-- Create Template for Album Info -->
		<script id="lastfmTemplateAlbumInfo" type="text/x-jsrender">
			<div class="album_info">
				<a href="{{:url}}" rel="nofollow" target="_blank"><img src="{{:image[2]['#text']}}" alt="{{:name}}" /></a>
				<p><b>Album Name: </b>{{:name}}</p>
				<p><b>Artist: </b>{{:artist}}</p>
				{{if releasedate}}
				<p><b>Release Date: </b>{{:releasedate}}</p>
				{{/if}}
				<ol>
				
				{{for tracks.track}}
					<li>
					<p style="text-align: left">
						{{>name}} - {{>~getMinute(duration)}}:{{if duration%60 < 10}}0{{>duration%60}}{{else}}{{>duration%60}}{{/if}}
					</p>
					</li>
				{{/for}}
				
				</ol>
				
			</div>
		</script>
		
		<!-- Create Template for Lyric Info -->
		<script id="lyricTemplate" type="text/x-jsrender">
			<div class="lyric_info">
				<a href="{{:url}}" rel="nofollow" target="_blank"><b>{{:name}}: </b><img src="{{:image[2]['#text']}}" alt="{{:name}}" /></a>
				<div><noindex>
					{{:bio.content}}
				</noindex></div>
			</div>
		</script>
		
		<!-- create template for top albums -->
		<script id="topAlbumsTemplate" type="text/x-jsrender">
			<div class="artist_info">
				<div class="artists">
				<h2> Top Albums
				</h2>
				<ol>
					{{for album}}
						{{if image}}
							<li>
							<p style="text-align: center"><b>{{:name}}</b></p>
								<a href="{{:url}}" rel="nofollow" target="_blank"><img src="{{:image[2]['#text']}}" alt="{{:name}}" /></a>
							</p>
							</li>
						{{/if}}
					{{/for}}
				</ol>
				
				</div>
			</div>
		</script>
		
		
		<!-- Template for Playlist -->
		<script id="playlist-template" type="text/x-jsrender">
			 <div class="playlist_info" style="position:relative; left: 38%; background-position:auto; background-image:url('https://u.scdn.co/images/pl/default/6fe20809fc11ebc90fd0f867f8ad6db5dd42b9cd'); height: 250px; width: 250px">			 
				 <div class="spotify_button"><a href="{{:external_urls.spotify}}"><img src="https://developer.spotify.com/wp-content/uploads/2014/06/play_on_spotify-green.png" /></a></div>
			 </div>
		
		</script>		
		
		
	</head>
	<body>

		<!-- Create Fixed Header Menu -->
		<div class="header">
			
			<div class="container">
				
				<div class="logo">
					<h1><a href="http://127.0.0.1:8080/EECS%20199/SoundStash.jsp" style="text-decoration: none; color: white;"><strong>SOUNDSTASH</strong></a></h1>
				</div>
				
				<div class="menu-trigger"> <a class="charts" style="font-size: 23px;">&#9776;</a></div>
				
				<div class="nav-menu">
					<ul>
						<li><a class="charts" href="http://127.0.0.1:8080/EECS%20199/SoundStash.jsp" >Home</a></li>
						<li><a class="charts" href="http://127.0.0.1:8080/EECS%20199/AboutUs.jsp" >About</a></li>
						<li><a class="charts" href="http://127.0.0.1:8080/EECS%20199/Charts.jsp" >Charts</a></li>
					</ul>
				</div>
				
				
			
			</div>
			
		</div>
		
		<div id="intro-SoundStash">
	
			<div class="col-md-6 col-md-offset-3">
				<p style="color:white; font-size: 50px; text-align:center; font-family: Arvo; margin-top: 50%">SOUNDSTASH</p>
				<h4 style="color:white; text-align:center; font-family:Arvo;">Explore the world of music.</h4>
			</div>
	
		</div>
			
		<!-- Top BillBoard 100 Playlist -->
		<div style="position:relative; left:-50px; margin-top: 40px;"> 
			<div class="col-md-6 col-md-offset-3">
				<div id="playlist-result"></div>
			</div>
		</div>	
			
		
		<script src="jquery-2.2.0.js"></script>
		<script type="text/javascript" src="jsrender.js"></script>
		<script type="text/javascript" src="spotify-web-api.js"></script>
		<script>
			
			var spotifyApi = new SpotifyWebApi();
			
			spotifyApi.setAccessToken('BQDaXQaUwS8rwZm7_SjYO4D5EPuukWl7on3v10azVKXQv72P-3aINbm0gdz2pnUWEkxIKLcGc9hvyQzKXgrMMdDNLs4XxVcK49uQThnX4R5s2dhZ_0j_N4K5uTEWCwbKrtzCPvXLzUgbKEANvXGVkaaP4gWRypHe0CtboulPxlSDnyxNP4S7uVOd9Yk5m1lj0CobBJU');
			spotifyApi.getPlaylist('billboard.com', '6UeSakyzhiEt4NB3UAd6NQ')
					.then(function(data){
						$('#playlist-result').empty().append(
							 $('#playlist-template').render(data)
						);
 
					}, function(err){
						console.error(err);
					});
					
		</script>
		
		<!-- Toggle Menu -->
		<script>
			$(document).ready(function(){
				$('.menu-trigger').click(function(){
					$('.nav-menu').slideToggle(400, function(){
						$(this).toggleClass("nav-expanded").css('display', '');
					});
				});
			
			});
		</script>
	
		<!-- Create Search and Input Fields -->
		<div class="row"> 
			 <div class="col-md-6 col-md-offset-3">
				<h2 style="color: white; font-family:Lato"></h2>
				<form action="#"> 
					<div id="inputBox" align="center">
						
						<label>	
							<span class="inputS"><b>Artist: </b><input type="text" id="search" placeholder="Enter artist name..." autocomplete="off" /></span>
						</label>
						<label>
							<span class="inputS"><b>Song: </b><input type="text" id="trackSearch" placeholder="Enter track name..." autocomplete="off" /></span>	
						</label>
						<label>
							<span class="inputS"><b>Album: </b><input type="text" id="albumSearch" placeholder="Enter album name..." autocomplete="off" /></span>
						</label>
						
					</div>
					
					<p><input id="buttn" type="button" value="Search" class="form-control btn btn-primary w100" /></p>
			
				</form> 
				
			</div>	
		</div>	
		
		<div class="wrap">
			<!-- Create a table to display results if any. -->
			<table align="center", width="95%">
				<thead>
					<tr>
							<th style="text-align: center; color:white; font-size:30px"><div id="headerOne"></div></th>
							<th style="text-align: center; color:white; font-size:30px"><div id="headerTwo"></div></th>
					</tr>
				</thead>

				<tbody>
				
					<tr>
						
						<td width="40%" valign="top">
							
							<div id="infoResults"></div>
							
							
						</td>
					
						<td width="60%" valign="top">
							
							<div id="topAlbumResults"></div>
							<div id ="blankline"></div>
							<div id="results"></div>
			
						</td>
						
						
					</tr>
					
				
				</tbody>
			</table>
		
		</div>
		
		<!-- Create Fixed foot Menu -->
		<div class="foot">
			<span style="color: white; font-family:Lato">&copy; 2016 Michael Andon All Rights Reserved.</span>
			
		</div>
					
		<!-- scripts -->
		
		<!-- YouTube -->
		<script src="jquery-2.2.0.js"></script>
		<script type="text/javascript" src="jsrender.js"></script>
		<script src="YTApp.js" type="text/javascript"></script>
		<script src="https://apis.google.com/js/client.js?onload=onClientLoad" type="text/javascript"></script>
	
		<!-- Last.fm -->
		<script type="text/javascript" src="lastfm.api.md5.js"></script>
		<script type="text/javascript" src="lastfm.api.js"></script>
		<script src="LastFMApp.js" type="text/javascript"></script> 

		
	</body>
	


</html>