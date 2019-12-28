$(function(){
  function appendComment(comment){
    html = `
            <div class="show__comments__box__comment">
              <img class="show__comments__box__comment__img" src="${comment.image}">
              <p class="show__comments__box__comment__user">${comment.nickname}</p>
              <p class="show__comments__box__comment__text current">${comment.text}</p>
              <p class="show__comments__box__comment__date">${comment.created_at}</p>
            </div>
            `
    $('.show__comments__box').append(html)
  }

  $(document).on("submit", ".show__comments__new", function(e){
    e.preventDefault();
    let href = $(".show__comments__new").attr("action");
    let formData = new FormData(this)
    $.ajax({
      url: href,
      type: "POST",
      dataType: "json",
      data: formData,
      processData: false,
      contentType: false
    })
    .done(function(comment){
      appendComment(comment)
      $('.show__comments__new')[0].reset();
      $('.show__comments__new__submit').removeAttr('disabled');
    })
    .fail(function(){
      alert("失敗しました。再読込をしてもう一度お試しください")
      $('.show__comments__new__submit').removeAttr('disabled');
    });
  })
})