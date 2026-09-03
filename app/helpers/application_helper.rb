module ApplicationHelper
    include Pagy::Frontend
    
    def low_stock_count
        @low_stock_count ||= Product.low_stock.count
    end
end
