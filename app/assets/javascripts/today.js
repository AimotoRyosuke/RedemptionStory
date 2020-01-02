$(function(){
  $('.form__category__today').on('click', function(){
    var today = new Date();
    var yyyy = today.getFullYear();
    var mm = ("0"+(today.getMonth()+1)).slice(-2);
    var dd = ("0"+today.getDate()).slice(-2);
    today = yyyy+'-'+mm+'-'+dd;
    $('.form__category__input--date').val(today)
  })
})