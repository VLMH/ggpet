module ResponseHelper
  def json_response(data, meta = {}, status = :ok)
    render json: data, root: "data", meta: meta, status: status
  end

  def pagination(objects, per_page)
    {
      page: objects.current_page,
      page_count: objects.total_pages,
      count: objects.total_count,
      perPage: per_page,
    }
  end

  def skip(page, per_page)
    per_page * (page.to_i - 1)
  end
end
