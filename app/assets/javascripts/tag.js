$(function(){
  let i = $(".tag-box").length;
  $("#tag").keypress(function(e){
    if(e.which == 13 && $("#tag").val() == 0){
      e.preventDefault();
    } else if(e.which == 13){
      e.preventDefault();
      let value = $("#tag").val();
      let html = `<li class="tag-box">
                    <input name="post[tags_attributes][${i}][name]" value="${value}" type="text" id="post_tags_attributes_${i}_tag" class="form__category__tag__hidden"> 
                    <label for="post_tags_attributes_${i}_tag" class="form__category__tag__show">${value}</label>
                    <p class="form__category__tag__delete" data-id=${i}>×<p>
                  </li>`;
      $(".form__category__tag").append(html);
      $("#tag").val("");
      i += 1;
    }
  });

  $(document).on('click', '.form__category__tag__delete', function(){
    $(this).parent().remove();
    let id = $(this).data("id");
    $(`#post_tags_attributes_${id}_id`).remove();
  });

  $(document).on("click", ".form__category__tag__destroy", function(){
    $(this).parent().attr("class", "tag-box--hidden")
  });
});