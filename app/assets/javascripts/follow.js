$(function(){

  function changeToUnfollow(html, user){
    html.attr("class", "user-page__left__unfollow")
    html.attr("id", "unfollow")
    html.text("フォロー中")
    html.data("url", `/users/${user.id}/unfollow`)
  }

  function changeToFollow(html, user){
    html.attr("class", "user-page__left__follow")
    html.attr("id", "follow")
    html.text("フォロー")
    html.data("url", `/users/${user.id}/follow`)
  }

  $(document).on("click", "#follow", function(){
    let url = $(this).data("url");
    let html = $(this)
    $.ajax({
      url: url,
      type: "PUT",
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(user){
      changeToUnfollow(html, user);
    })
    .fail(function(){
      alert("フォローに失敗しました。再読み込みをしてやり直してください。")
    });
  });

  $(document).on("click", "#unfollow", function(){
    let url = $(this).data("url");
    let html = $(this)
    $.ajax({
      url: url,
      type: "PUT",
      dataType: "json",
      processData: false,
      contentType: false
    })
    .done(function(user){
      changeToFollow(html, user);
    })
    .fail(function(){
      alert("フォローに失敗しました。再読み込みをしてやり直してください。")
    });
  });
});