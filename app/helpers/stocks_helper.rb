module StocksHelper
  def item_stock_link_to(item)
    if logged_in?
      if current_user.stocking? item
        link_to 'ストックを解除', item_stock_path(item), remote: true, method: :delete, class: 'btn btn-danger btn-block'
      else
        link_to 'ストック', item_stock_path(item), remote: true, method: :post, class: 'btn btn-success btn-block'
      end
    else
      link_to 'ストック', login_path, class: 'btn btn-success btn-block'
    end
  end
end

