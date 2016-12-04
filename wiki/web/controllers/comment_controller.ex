defmodule Wiki.CommentController do
  use Wiki.Web, :controller

  alias Wiki.Comment

  def index(conn, _params) do
    page = load_page(conn)
    comments = Repo.all(assoc(page, :comments))
    render(conn, "index.html", comments: comments, page: page)
  end

  def new(conn, _params) do
    page = load_page(conn)
    changeset = Comment.changeset(%Comment{})
    render(conn, "new.html", changeset: changeset, page: page)
  end

  def create(conn, %{"comment" => comment_params}) do
    page = load_page(conn)
    changeset = Comment.changeset(%Comment{id: page.id}, comment_params)
    Wiki.Endpoint.broadcast! "page:#{page.id}", "new_comment", %{}

    case Repo.insert(changeset) do
      {:ok, _comment} ->
        conn
        |> put_flash(:info, "Comment created successfully.")
        |> redirect(to: page_comment_path(conn, :index, page.id))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset, page: page)
    end
  end

  def delete(conn, %{"id" => id}) do
    page = load_page(conn)
    comment = Repo.get!(assoc(page, :comments), id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(comment)

    Wiki.Endpoint.broadcast! "page:#{page.id}", "comment_deleted", %{}

    conn
    |> put_flash(:info, "Comment deleted successfully.")
    |> redirect(to: page_comment_path(conn, :index, page))
  end

  defp load_page(conn) do
    Wiki.Page
    |> Repo.get_by!(id: conn.params["page_id"])
    |> Repo.preload([:comments])
  end
end
