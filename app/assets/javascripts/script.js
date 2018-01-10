// Update your footer by https://jusleg.com
$( document ).ready(function() {
  var footer = document.getElementById("yearfooter");
  var date = new Date();
  date = date.getYear().toString();
  date = "20"+ date.substring(1,3);
  footer.innerHTML=date;
  $('.dropdown-button').click('open');
});
