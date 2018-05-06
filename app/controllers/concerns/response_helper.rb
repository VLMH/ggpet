module ResponseHelper
  def json_response(body, meta = {}, status = :ok)
    content = {
      meta: meta,
      data: body,
    }
    render json: content, status: status
  end

  def pagination(page, count, per_page)
    {
      page: page,
      page_count: (count.to_f / per_page).ceil,
      count: count,
      perPage: per_page,
    }
  end

  def skip(page, per_page)
    per_page * (page.to_i - 1)
  end
end
