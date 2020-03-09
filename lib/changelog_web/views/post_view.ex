defmodule ChangelogWeb.PostView do
  use ChangelogWeb, :public_view

  alias Changelog.Files
  alias ChangelogWeb.{Endpoint, NewsItemView, PersonView}

  def admin_edit_link(conn, %{admin: true}, post) do
    path = admin_post_path(conn, :edit, post, next: current_path(conn))
    link("[edit]", to: path, data: [turbolinks: false])
  end
  def admin_edit_link(_, _, _), do: nil

  def guid(post), do: post.guid || "changelog.com/posts/#{post.id}"

  def image_mime_type(post), do: Files.Image.mime_type(post.image)

  def image_path(post, version) do
    {post.image, post}
    |> Files.Image.url(version)
    |> String.replace_leading("/priv", "")
  end

  def image_url(post, version) do
    static_url(Endpoint, image_path(post, version))
  end

  def url(post, action), do: post_url(Endpoint, action, post.slug)
end
