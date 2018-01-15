// Update your footer by https://jusleg.com
$( document ).ready(function() {
  var footer = document.getElementById("yearfooter");
  var date = new Date();
  date = date.getYear().toString();
  date = "20"+ date.substring(1,3);
  footer.innerHTML=date;
});

// Add space between licence plate AAA AAA
function formatInput() {
  var element = document.getElementById('plate-input');
  var plateval = document.getElementById('plate-input').value;
  var size = plateval.length;
  var key = event.keyCode || event.charCode;
  if (size == 3 && key != 8 && key != 32) {//8=backscpace, 32 = space
    element.value = plateval+" ";
  }
}

// Make the car on the new ranking form go zoom zoom
$(function() {
  $('#plate-input').hover(function() {
    $('#zoomzoom').css('margin-left', '94vw');
  }, function() {
    // on mouseout, move back to oriiginal postion
    $('#zoomzoom').css('margin-left', '40px');
  });
});

// Load disqus chat on button click
$(document).ready(function() {
  $('.show-comments').on('click', function(){
    var disqus_shortname = 'driverrank-ca';
    // ajax request to load the disqus javascript
    $.ajax({
      type: "GET",
      url: "https://" + disqus_shortname + ".disqus.com/embed.js",
      dataType: "script",
      cache: true
    });
  });
});
