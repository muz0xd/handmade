module PostsHelper
  def cut_post_body_by_tag post
    cutted_text = post.body[/(.+)\[!cut!\]/m,1]
    if cutted_text.blank?
      cutted_text = post.body
    else
      cutted_text += "<a href =" + post_path(post) + ">Читать дальше</a>"
    end
    cutted_text
  end
  def delete_tag_from_post_body body
    text = body.dup
    text.slice!(/\[!cut!\]/)
    text
  end
end
