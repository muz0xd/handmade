module PostsHelper
  def cut_post_body_by_tag text
    cutted_text = text[/(.+)\[!cut!\]/m,1]
    if cutted_text.blank?
      cutted_text = text
    end
    cutted_text
  end
  def delete_tag_from_post_body body
    text = body.dup
    text.slice!(/\[!cut!\]/)
    text
  end
end
