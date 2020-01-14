$(function(){
  $(".signup__form__group__image").on("change", function(e){
    $(".signup__form__group__image__input").attr("class", "signup__form__group__image__change");
    $(".signup__form__group__image__change").text("変更");
    $(".signup__form__group__image__delete").remove();
    $(".signup__form__group__image").append(`<p class="signup__form__group__image__delete">削除</p>`);
    $(".signup__form__group__image__show").remove();
    let image = new FileReader();
    image.onload = function(e){
      $(".signup__form__group__image").prepend(`<img src=${e.target.result} class="signup__form__group__image__show">`);
    }
    image.readAsDataURL(e.target.files[0]);
  });

  $(document).on("click", ".signup__form__group__image__delete", function(){
    $(".signup__form__group__image").empty();
    $(".signup__form__group__image").append(`
                                            <input class="signup__form__group__image__hidden" accept="image/*" type="file" name="user[image]" id="user_image">
                                            <label class="signup__form__group__image__input" for="user_image">クリックして画像を選択</label>`
    );
  })

  $(".user-edit__form__group__image").on("change", function(e){
    $(".user-edit__form__group__image__input").attr("class", "user-edit__form__group__image__change");
    $(".user-edit__form__group__image__change").text("変更");
    $(".user-edit__form__group__image__show").remove();
    let image = new FileReader();
    image.onload = function(e){
      $(".user-edit__form__group__image").prepend(`<img src=${e.target.result} class="user-edit__form__group__image__show">`);
    }
    image.readAsDataURL(e.target.files[0]);
  });
});