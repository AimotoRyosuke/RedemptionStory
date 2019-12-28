json.comment_id @comment.id
json.nickname   @comment.user.nickname
json.post_id    @comment.post_id
json.text       @comment.text
json.created_at @comment.created_at.strftime("%Y/%m/%d %H:%M")
json.image      @comment.user.image.url