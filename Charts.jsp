<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">



<html>
	<head>
		<title>SoundStash - About</title>
		<meta charset="UTF-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<meta name="description" content="About" />
		
		<!-- Links -->
		<link type="text/css" rel="stylesheet" href="stylesheet.css"/>
		<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
		<link rel="stylesheet" type="text/css" href="https://fonts.googleapis.com/css?family=Lato"/>
			
		<!-- Hip Hop -->	
		<script id="lastfmTemplateArtists" type="text/x-jsrender">
			
			<div class="artists">
			{{for artist}}
				
				<li id="artistList">
				<p style="text-align: center"><b>{{:name}}</b></p>
				<p style="margin-bottom: 50px;">
					<a href="{{:url}}" rel="nofollow" target="_blank"><img src="{{:image[2]['#text']}}" alt="{{:name}}"/></a>
				</p>
				</li>
			{{/for}}
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
				
				<div class="menu-trigger"> <span style="font-size: 23px;">&#9776;</span></div>
				
				<div class="nav-menu">
					<ul>
						<li><a class="charts" href="http://127.0.0.1:8080/EECS%20199/SoundStash.jsp" >Home</a></li>
						<li><a class="charts" href="http://127.0.0.1:8080/EECS%20199/AboutUs.jsp" >About</a></li>
						<li><a class="charts" href="http://127.0.0.1:8080/EECS%20199/Charts.jsp" >Charts</a></li>
					</ul>
				</div>
				
				
			
			</div>
			
		</div>
		<!-- End of Fixed Header Menu -->
		
		<!-- Content -->
		<div class="wrap" style="margin-top: 120px;">
			<!-- Hip-Hop Artists Table -->
			<table align="center", width="95%">
				<thead>
					<tr>
							<th style="text-align: center; color:white; font-size:30px; padding-top: 20px;">Top Hip-Hop Artists</th>
					</tr>
				</thead>

				<tbody>
				
					<tr>
					
						<td>
							<div id="artists_info"></div>
			
						</td>
						
					</tr>
				
				</tbody>
			</table>
			
			<!-- Pop Artists Table -->
			<table align="center", width="95%">
				<thead>
					<tr>
							<th style="text-align: center; color:white; font-size:30px; padding-top: 20px;">Top Pop Artists</th>
					</tr>
				</thead>

				<tbody>
				
					<tr>
					
						<td>
							<div id="popArtists_info"></div>
			
						</td>
						
					</tr>
				
				</tbody>
			</table>
			
			<!-- Indie Artists Table -->
			<table align="center", width="95%">
				<thead>
					<tr>
							<th style="text-align: center; color:white; font-size:30px; padding-top: 20px;">Top Indie Artists</th>
					</tr>
				</thead>

				<tbody>
				
					<tr>
					
						<td>
							<div id="indieArtists_info"></div>
			
						</td>
						
					</tr>
				
				</tbody>
			</table>
			
			<!-- Alternative Artists Table -->
			<table align="center", width="95%">
				<thead>
					<tr>
							<th style="text-align: center; color:white; font-size:30px; padding-top: 20px;">Top Alternative Artists</th>
					</tr>
				</thead>

				<tbody>
				
					<tr>
					
						<td>
							<div id="alternativeArtists_info"></div>
			
						</td>
						
					</tr>
				
				</tbody>
			</table>
			
			<!-- Electronic Artists Table -->
			<table align="center", width="95%">
				<thead>
					<tr>
							<th style="text-align: center; color:white; font-size:30px; padding-top: 20px;">Top Electronic Artists</th>
					</tr>
				</thead>

				<tbody>
				
					<tr>
					
						<td>
							<div id="electronicArtists_info"></div>
			
						</td>
						
					</tr>
				
				</tbody>
			</table>
			
		
		</div>

		
			<!-- Last.fm -->
		<script type="text/javascript" src="lastfm.api.md5.js"></script>
		<script type="text/javascript" src="lastfm.api.js"></script>	
		<script>
		 
			var apiKey = 'e2ee33a23a2c546f5b2c427f3c4912b4';
			var apiSecret = '2e25ea5cd8113d79c53892b29668819c';
			// define api keys
			var lastfm = new LastFM({
				apiKey: apiKey,
				apiSecret: apiSecret
			});
	
			var topArtists = lastfm.tag.getTopArtists({
				tag: 'Hip-Hop', 
				limit: 5}, 
				{success: function(data){
					$('#artists_info').empty().append(
						$('#lastfmTemplateArtists').render(data.topartists)
					);
				}, error: function(data){
						/* Show error message. */
						alert(data.error + " " + data.message);
					}
			});
			
			var topPopArtists = lastfm.tag.getTopArtists({
				tag: 'Pop', 
				limit: 5}, 
				{success: function(data){
					$('#popArtists_info').empty().append(
						$('#lastfmTemplateArtists').render(data.topartists)
					);
				}, error: function(data){
						/* Show error message. */
						alert(data.error + " " + data.message);
					}
			});
			
			var topIndieArtists = lastfm.tag.getTopArtists({
				tag: 'Indie', 
				limit: 5}, 
				{success: function(data){
					$('#indieArtists_info').empty().append(
						$('#lastfmTemplateArtists').render(data.topartists)
					);
				}, error: function(data){
						/* Show error message. */
						alert(data.error + " " + data.message);
					}
			});
			
			var topAltArtists = lastfm.tag.getTopArtists({
				tag: 'Alternative', 
				limit: 5}, 
				{success: function(data){
					$('#alternativeArtists_info').empty().append(
						$('#lastfmTemplateArtists').render(data.topartists)
					);
				}, error: function(data){
						/* Show error message. */
						alert(data.error + " " + data.message);
					}
			});

			var topElectronicArtists = lastfm.tag.getTopArtists({
				tag: 'Electronic', 
				limit: 5}, 
				{success: function(data){
					$('#electronicArtists_info').empty().append(
						$('#lastfmTemplateArtists').render(data.topartists)
					);
				}, error: function(data){
						/* Show error message. */
						alert(data.error + " " + data.message);
					}
			});
			
		
		</script>
		
		<!-- Create Fixed foot Menu -->
		<div class="foot">
			<span style="color: white; font-family:Lato">&copy; 2016 Michael Andon All Rights Reserved.</span>

		</div>
					
		<!-- scripts -->
		
		<!-- YouTube -->
		<script src="jquery-2.2.0.js"></script>
		<script type="text/javascript" src="jsrender.js"></script>
		
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
	
	</body>
	


</html>